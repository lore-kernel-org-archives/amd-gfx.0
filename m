Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3635C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822E220767
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RC3vV+li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822E220767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1546E896;
	Tue, 16 Jun 2020 10:24:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20256E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 10:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI2LWQSjI8QXlm3MnlAw++0Qihsr/ojmjLmIxVbLiSMt+S2MLEtXM6w1J1D9HMzKE16fJ8vuZ99uyCv5o8PWqijt8It73EvhyqcW+PAJ/zX+Y+akGYnmKh4A6fUDfIcCr+VVoFMCfb2xQNlSejT8sy8jxwGS0EqrINAS6jAlWY7/DpWqXfdq+ToCkadyU0mmt4vU1YSlrGbrJvPYOPEuxLaaz4DLDvH8QeZNcnSSi/MwBiKQddTS9nTKa6qvGbFGcpXArW1eKlGmRAdNPjw+OBxkbvD5f47RjOYQaLRmkzO+x1DH6l07GCFUoGc8bqpJa+bU8eETpu9Kk8Cxb1lWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbbWzOUhwphi0HmfFV9rDNud5C0uieZL4vDqqO37bLg=;
 b=YlGvN8YEtQb4Qr50Xsd9eXEc0B9BWJ6ez4s+2cYgDqZgTHMZM3JZp4Qfhb4yIajLu5IL5LvY5V1dR9wLluEeyghHcj9DmapGbW6EvrK7jE3mkhifrAV1ytkrlzyL35xb5WIkZQ6pGRS0CQ03BU0pVrNB62CKFBoIkX9BAajb180TYMx86ubNmduAz+PgYfzzmvBQfShm9I+QFRnmIOin37MOvV/wddAePxGgmvlVCLQRl8BIdjWiHC9eRE7zYGHDxRGw4uWevEhDWPRhXC6w/DjFNMS9b9PZOLIYqwx24Pj6XZcAnoHPiL+w0YIwMC9/X0Je5yfE67gQnT93Fa1Jmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbbWzOUhwphi0HmfFV9rDNud5C0uieZL4vDqqO37bLg=;
 b=RC3vV+li7Cnil1No3nSf3/DsGj4Nej5Xz4oM0GENVYnpmq35bsuYXmKaoWquJPSkX/t+hc8gNn+XAuztT/YfBdzajr4xRx3F9z2qnpCo8USQhmOlajpsp9PVIwotz1wGxRls6Yob1L1najQjkB/0OT1s9LSyEir07NIshHOmqLs=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:24:45 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:24:45 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos
Thread-Topic: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos
Thread-Index: AQHWQ6yiGGbxsNgbBEqYrIy0LzkyEKjbA1OAgAAEe2A=
Date: Tue, 16 Jun 2020 10:24:44 +0000
Message-ID: <MN2PR12MB302299A4E004E950DB0B5553A29D0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200616070546.4190-1-kevin1.wang@amd.com>
 <20200616070546.4190-2-kevin1.wang@amd.com>,
 <DM6PR12MB4075010E37CD01131FF6B279FC9D0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075010E37CD01131FF6B279FC9D0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-16T10:24:44.246Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca1e063d-e012-47d5-5e3a-08d811df7d57
x-ms-traffictypediagnostic: MN2PR12MB3024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3024F258D1D154F883C92371A29D0@MN2PR12MB3024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4yGzsCKozDKU3pOuVHf0ZizI3xbcQKOxreCkfartnKpV9LWRPGTpyVLEHdGX7mnLB4NPfHXHvITzq1uDZFEYdOfmca7L/Rc/Nn5vllpzEd42NMghbdiRkBvyOTVWGNGgg7BkBLZ9XzX+uxfeaunGX55HTp9Gai3nLtH/x3WCg5fHoR12hRt8G3PvOwVOISLgF600AKaSH/MA1Jha7fm1PXujD5qYtRbz1x2HPpJ8V1M5QUN4gdDiNzAfbelqFaSWW0gVJ8iOCejkHBA8aIJFzM/s+EgqBdKFk5hC8dsMNamlJm3IXcOpG9A9+7iGzz9Eo3i+KQEWT8YiuFfpyDC561h/HEN4W/cmP04Rctj1qQ/wkipeRAQZgEOeAG12IVh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(66946007)(71200400001)(76116006)(91956017)(66556008)(86362001)(66476007)(66446008)(9686003)(110136005)(64756008)(52536014)(55016002)(316002)(7696005)(8676002)(66574015)(6506007)(26005)(53546011)(8936002)(19627405001)(186003)(2906002)(83380400001)(478600001)(4326008)(5660300002)(30864003)(33656002)(21314003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CW5rDxfft+5LrqevcF+Tip/B4zCzjgb+EqwJCJ4W8xVTYewNEUndXwND3Vcp15dJepYE/QuIxCdy2mvKaeepQERV1VVFnfKFfivBT5d849IRITOdkApFHX+aciChHouHX+qhHE2wrlwodojLjP/EEE8a+hLvFO4nxu4J5EVjcDTpcUaCnOksjwsy58No6nnyy455P2WbBrtb30JZALCjBfhzpXXBKTnNHQpY4XQnWJGi8Zul3tWZSICKbBbQC8OU315isALZBdPIRJg2nreJpJOJoWXFYdR6bJzRaMikLdnG0fV0sz2wPe2M1RF4Jt29Vn+r8/Ouvlf2pxgPQfeZC9kEB4iVWiIAa+7+77UeRu58T94vBH0r2Szr+2e89V7KXwnVKhUIN1fan1wIzDsd2FtE9PHH98ecdE0tGyn3cVHXEC0rmm9bitwDGPmchavs4xmyuIbj2XS0JgYO+ME8AxNXpWoQDud6k/4V6zh0le3ngclVOXAGQ+w2SXRJOCAK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1e063d-e012-47d5-5e3a-08d811df7d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 10:24:44.9652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNcmRTLkyx0ephQ8cpSS9W9ivWlUSljZ+XE1dVqAU0zbZHgxvwpFNcsKlVpEOvd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0563875517=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0563875517==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302299A4E004E950DB0B5553A29D0MN2PR12MB3022namp_"

--_000_MN2PR12MB302299A4E004E950DB0B5553A29D0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

yes, i can rename the marco "smu_ppt_xxx" to "smu_ppt_funs".
but in kernel code, we can see the same code style, likes:
path: //include/linux/cred.h
#define task_cred_xxx(task, xxx)                        \
({                                                      \
        __typeof__(((struct cred *)NULL)->xxx) ___val;  \
        rcu_read_lock();                                \
        ___val =3D __task_cred((task))->xxx;              \
        rcu_read_unlock();                              \
        ___val;                                         \
})

#define task_uid(task)          (task_cred_xxx((task), uid))
#define task_euid(task)         (task_cred_xxx((task), euid))

#define current_cred_xxx(xxx)                   \
({                                              \
        current_cred()->xxx;                    \
})

#define current_uid()           (current_cred_xxx(uid))
#define current_gid()           (current_cred_xxx(gid))
#define current_euid()          (current_cred_xxx(euid))
#define current_egid()          (current_cred_xxx(egid))
#define current_suid()          (current_cred_xxx(suid))
#define current_sgid()          (current_cred_xxx(sgid))
#define current_fsuid()         (current_cred_xxx(fsuid))
#define current_fsgid()         (current_cred_xxx(fsgid))
#define current_cap()           (current_cred_xxx(cap_effective))
#define current_user()          (current_cred_xxx(user))

anyway, i will send a new patch to correct it.
thanks.

Best Regards,
Kevin
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, June 16, 2020 6:03 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos

[AMD Public Use]

The naming style smu_ppt_xxx makes me confusing..... at first glance, I tho=
ught you just have some dummy code or the patch is something still working =
in progress. It would be better to rename it to smu_ppt_funcs.

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, June 16, 2020 15:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos

add the new macro "smu_ppt_xxx()" to unify smu callback interfaces

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 266 ++++++-------------
 1 file changed, 82 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h
index 880ef54884f8..0f9841bcdcb8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -25,191 +25,89 @@

 #include "amdgpu_smu.h"

-#define smu_init_microcode(smu) \
-       ((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcod=
e((smu)) : 0)
-#define smu_fini_microcode(smu) \
-       ((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcod=
e((smu)) : 0)
-#define smu_init_smc_tables(smu) \
-       ((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tab=
les((smu)) : 0)
-#define smu_fini_smc_tables(smu) \
-       ((smu)->ppt_funcs->fini_smc_tables ? (smu)->ppt_funcs->fini_smc_tab=
les((smu)) : 0)
-#define smu_init_power(smu) \
-       ((smu)->ppt_funcs->init_power ? (smu)->ppt_funcs->init_power((smu))=
 : 0)
-#define smu_fini_power(smu) \
-       ((smu)->ppt_funcs->fini_power ? (smu)->ppt_funcs->fini_power((smu))=
 : 0)
-
-#define smu_setup_pptable(smu) \
-       ((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable(=
(smu)) : 0)
-#define smu_powergate_sdma(smu, gate) \
-       ((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdm=
a((smu), (gate)) : 0)
-
-#define smu_get_vbios_bootup_values(smu) \
-       ((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_=
vbios_bootup_values((smu)) : 0)
-#define smu_check_fw_version(smu) \
-       ((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_ve=
rsion((smu)) : 0)
-#define smu_write_pptable(smu) \
-       ((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable(=
(smu)) : 0)
-#define smu_set_min_dcef_deep_sleep(smu, clk) \
-       ((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_=
min_dcef_deep_sleep((smu), (clk)) : 0)
-#define smu_set_driver_table_location(smu) \
-       ((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->se=
t_driver_table_location((smu)) : 0)
-#define smu_set_tool_table_location(smu) \
-       ((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_=
tool_table_location((smu)) : 0)
-#define smu_notify_memory_pool_location(smu) \
-       ((smu)->ppt_funcs->notify_memory_pool_location ? (smu)->ppt_funcs->=
notify_memory_pool_location((smu)) : 0)
-#define smu_gfx_off_control(smu, enable) \
-       ((smu)->ppt_funcs->gfx_off_control ? (smu)->ppt_funcs->gfx_off_cont=
rol((smu), (enable)) : 0)
-
-#define smu_set_last_dcef_min_deep_sleep_clk(smu) \
-       ((smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk ? (smu)->ppt_fu=
ncs->set_last_dcef_min_deep_sleep_clk((smu)) : 0)
-#define smu_system_features_control(smu, en) \
-       ((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->syst=
em_features_control((smu), (en)) : 0)
-#define smu_init_max_sustainable_clocks(smu) \
-       ((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->=
init_max_sustainable_clocks((smu)) : 0)
-#define smu_set_default_od_settings(smu) \
-       ((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_=
default_od_settings((smu)) : 0)
-
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
-       ((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_=
smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
-
-static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_messa=
ge_type msg, uint32_t *read_arg) {
-       return smu_send_smc_msg_with_param(smu, msg, 0, read_arg);
-}
-
-#define smu_alloc_dpm_context(smu) \
-       ((smu)->ppt_funcs->alloc_dpm_context ? (smu)->ppt_funcs->alloc_dpm_=
context((smu)) : 0)
-#define smu_init_display_count(smu, count) \
-       ((smu)->ppt_funcs->init_display_count ? (smu)->ppt_funcs->init_disp=
lay_count((smu), (count)) : 0)
-#define smu_feature_set_allowed_mask(smu) \
-       ((smu)->ppt_funcs->set_allowed_mask? (smu)->ppt_funcs->set_allowed_=
mask((smu)) : 0)
-#define smu_feature_get_enabled_mask(smu, mask, num) \
-       ((smu)->ppt_funcs->get_enabled_mask? (smu)->ppt_funcs->get_enabled_=
mask((smu), (mask), (num)) : 0)
-#define smu_is_dpm_running(smu) \
-       ((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs->is_dpm_runnin=
g((smu)) : 0)
-#define smu_notify_display_change(smu) \
-       ((smu)->ppt_funcs->notify_display_change? (smu)->ppt_funcs->notify_=
display_change((smu)) : 0)
-#define smu_set_default_dpm_table(smu) \
-       ((smu)->ppt_funcs->set_default_dpm_table ? (smu)->ppt_funcs->set_de=
fault_dpm_table((smu)) : 0)
-#define smu_populate_umd_state_clk(smu) \
-       ((smu)->ppt_funcs->populate_umd_state_clk ? (smu)->ppt_funcs->popul=
ate_umd_state_clk((smu)) : 0)
-#define smu_set_default_od8_settings(smu) \
-       ((smu)->ppt_funcs->set_default_od8_settings ? (smu)->ppt_funcs->set=
_default_od8_settings((smu)) : 0)
-
-#define smu_get_current_clk_freq(smu, clk_id, value) \
-       ((smu)->ppt_funcs->get_current_clk_freq? (smu)->ppt_funcs->get_curr=
ent_clk_freq((smu), (clk_id), (value)) : 0)
-
-#define smu_tables_init(smu, tab) \
-       ((smu)->ppt_funcs->tables_init ? (smu)->ppt_funcs->tables_init((smu=
), (tab)) : 0)
-#define smu_set_thermal_fan_table(smu) \
-       ((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_th=
ermal_fan_table((smu)) : 0)
-#define smu_enable_thermal_alert(smu) \
-       ((smu)->ppt_funcs->enable_thermal_alert? (smu)->ppt_funcs->enable_t=
hermal_alert((smu)) : 0)
-#define smu_disable_thermal_alert(smu) \
-       ((smu)->ppt_funcs->disable_thermal_alert? (smu)->ppt_funcs->disable=
_thermal_alert((smu)) : 0)
-
-#define smu_smc_read_sensor(smu, sensor, data, size) \
-       ((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu)=
, (sensor), (data), (size)) : -EINVAL)
-
-#define smu_pre_display_config_changed(smu) \
-       ((smu)->ppt_funcs->pre_display_config_changed ? (smu)->ppt_funcs->p=
re_display_config_changed((smu)) : 0)
-#define smu_display_config_changed(smu) \
-       ((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs->displ=
ay_config_changed((smu)) : 0)
-#define smu_apply_clocks_adjust_rules(smu) \
-       ((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs->ap=
ply_clocks_adjust_rules((smu)) : 0)
-#define smu_notify_smc_display_config(smu) \
-       ((smu)->ppt_funcs->notify_smc_display_config ? (smu)->ppt_funcs->no=
tify_smc_display_config((smu)) : 0)
-#define smu_force_dpm_limit_value(smu, highest) \
-       ((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs->force_=
dpm_limit_value((smu), (highest)) : 0)
-#define smu_unforce_dpm_levels(smu) \
-       ((smu)->ppt_funcs->unforce_dpm_levels ? (smu)->ppt_funcs->unforce_d=
pm_levels((smu)) : 0)
+#define smu_ppt_xxx(intf, ret, smu, args...) \
+       ((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->int=
f(smu, ##args) : ret) : -EINVAL)
+
+#define smu_init_microcode(smu)                                           =
     smu_ppt_xxx(init_microcode, 0, smu)
+#define smu_fini_microcode(smu)                                           =
     smu_ppt_xxx(fini_microcode, 0, smu)
+#define smu_init_smc_tables(smu)                                       smu=
_ppt_xxx(init_smc_tables, 0, smu)
+#define smu_fini_smc_tables(smu)                                       smu=
_ppt_xxx(fini_smc_tables, 0, smu)
+#define smu_init_power(smu)                                            smu=
_ppt_xxx(init_power, 0, smu)
+#define smu_fini_power(smu)                                            smu=
_ppt_xxx(fini_power, 0, smu)
+#define smu_setup_pptable(smu)                                         smu=
_ppt_xxx(setup_pptable, 0, smu)
+#define smu_powergate_sdma(smu, gate)                                  smu=
_ppt_xxx(powergate_sdma, 0, smu, gate)
+#define smu_get_vbios_bootup_values(smu)                               smu=
_ppt_xxx(get_vbios_bootup_values, 0, smu)
+#define smu_check_fw_version(smu)                                      smu=
_ppt_xxx(check_fw_version, 0, smu)
+#define smu_write_pptable(smu)                                         smu=
_ppt_xxx(write_pptable, 0, smu)
+#define smu_set_min_dcef_deep_sleep(smu, clk)                          smu=
_ppt_xxx(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_driver_table_location(smu)                             smu=
_ppt_xxx(set_driver_table_location, 0, smu)
+#define smu_set_tool_table_location(smu)                               smu=
_ppt_xxx(set_tool_table_location, 0, smu)
+#define smu_notify_memory_pool_location(smu)                           smu=
_ppt_xxx(notify_memory_pool_location, 0, smu)
+#define smu_gfx_off_control(smu, enable)                               smu=
_ppt_xxx(gfx_off_control, 0, smu, enable)
+#define smu_set_last_dcef_min_deep_sleep_clk(smu)                      smu=
_ppt_xxx(set_last_dcef_min_deep_sleep_clk, 0, smu)
+#define smu_system_features_control(smu, en)                           smu=
_ppt_xxx(system_features_control, 0, smu, en)
+#define smu_init_max_sustainable_clocks(smu)                           smu=
_ppt_xxx(init_max_sustainable_clocks, 0, smu)
+#define smu_set_default_od_settings(smu)                               smu=
_ppt_xxx(set_default_od_settings, 0, smu)
+#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)         smu=
_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
+#define smu_send_smc_msg(smu, msg, read_arg)                           smu=
_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
+#define smu_alloc_dpm_context(smu)                                     smu=
_ppt_xxx(alloc_dpm_context, 0, smu)
+#define smu_init_display_count(smu, count)                             smu=
_ppt_xxx(init_display_count, 0, smu, count)
+#define smu_feature_set_allowed_mask(smu)                              smu=
_ppt_xxx(set_allowed_mask, 0, smu)
+#define smu_feature_get_enabled_mask(smu, mask, num)                   smu=
_ppt_xxx(get_enabled_mask, 0, smu, mask, num)
+#define smu_is_dpm_running(smu)                                           =
     smu_ppt_xxx(is_dpm_running, 0 , smu)
+#define smu_notify_display_change(smu)                                 smu=
_ppt_xxx(notify_display_change, 0, smu)
+#define smu_set_default_dpm_table(smu)                                 smu=
_ppt_xxx(set_default_dpm_table, 0, smu)
+#define smu_populate_umd_state_clk(smu)                                   =
     smu_ppt_xxx(populate_umd_state_clk, 0, smu)
+#define smu_set_default_od8_settings(smu)                              smu=
_ppt_xxx(set_default_od8_settings, 0, smu)
+#define smu_get_current_clk_freq(smu, clk_id, value)                   smu=
_ppt_xxx(get_current_clk_freq, 0, smu, clk_id, value)
+#define smu_tables_init(smu, tab)                                      smu=
_ppt_xxx(tables_init, 0, smu, tab)
+#define smu_set_thermal_fan_table(smu)                                 smu=
_ppt_xxx(set_thermal_fan_table, 0, smu)
+#define smu_enable_thermal_alert(smu)                                  smu=
_ppt_xxx(enable_thermal_alert, 0, smu)
+#define smu_disable_thermal_alert(smu)                                 smu=
_ppt_xxx(disable_thermal_alert, 0, smu)
+#define smu_smc_read_sensor(smu, sensor, data, size)                   smu=
_ppt_xxx(read_sensor, -EINVAL, smu, sensor, data, size)
+#define smu_pre_display_config_changed(smu)                            smu=
_ppt_xxx(pre_display_config_changed, 0, smu)
+#define smu_display_config_changed(smu)                                   =
     smu_ppt_xxx(display_config_changed, 0 , smu)
+#define smu_apply_clocks_adjust_rules(smu)                             smu=
_ppt_xxx(apply_clocks_adjust_rules, 0, smu)
+#define smu_notify_smc_display_config(smu)                             smu=
_ppt_xxx(notify_smc_display_config, 0, smu)
+#define smu_force_dpm_limit_value(smu, highest)                           =
     smu_ppt_xxx(force_dpm_limit_value, 0, smu, highest)
+#define smu_unforce_dpm_levels(smu)                                    smu=
_ppt_xxx(unforce_dpm_levels, 0, smu)
+#define smu_set_cpu_power_state(smu)                                   smu=
_ppt_xxx(set_cpu_power_state, 0, smu)
+#define smu_msg_get_index(smu, msg)                                    smu=
_ppt_xxx(get_smu_msg_index, -EINVAL, smu, msg)
+#define smu_clk_get_index(smu, clk)                                    smu=
_ppt_xxx(get_smu_clk_index, -EINVAL, smu, clk)
+#define smu_feature_get_index(smu, fea)                                   =
     smu_ppt_xxx(get_smu_feature_index, -EINVAL, smu, fea)
+#define smu_table_get_index(smu, tab)                                  smu=
_ppt_xxx(get_smu_table_index, -EINVAL, smu, tab)
+#define smu_power_get_index(smu, src)                                  smu=
_ppt_xxx(get_smu_power_index, -EINVAL, smu, src)
+#define smu_workload_get_type(smu, type)                               smu=
_ppt_xxx(get_smu_power_index, -EINVAL, smu, type)
+#define smu_run_btc(smu)                                               smu=
_ppt_xxx(run_btc, 0, smu)
+#define smu_get_allowed_feature_mask(smu, feature_mask, num)           smu=
_ppt_xxx(get_allowed_feature_mask, 0, smu, feature_mask, num)
+#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)      smu=
_ppt_xxx(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
+#define smu_get_dal_power_level(smu, clocks)                           smu=
_ppt_xxx(get_dal_power_level, 0, smu, clocks)
+#define smu_get_perf_level(smu, designation, level)                    smu=
_ppt_xxx(get_perf_level, 0, smu, designation, level)
+#define smu_get_current_shallow_sleep_clocks(smu, clocks)              smu=
_ppt_xxx(get_current_shallow_sleep_clocks, 0, smu, clocks)
+#define smu_dpm_set_vcn_enable(smu, enable)                            smu=
_ppt_xxx(dpm_set_vcn_enable, 0, smu, enable)
+#define smu_dpm_set_jpeg_enable(smu, enable)                           smu=
_ppt_xxx(dpm_set_jpeg_enable, 0, smu, enable)
+#define smu_set_watermarks_table(smu, tab, clock_ranges)               smu=
_ppt_xxx(set_watermarks_table, 0, smu, tab, clock_ranges)
+#define smu_get_current_clk_freq_by_table(smu, clk_type, value)           =
     smu_ppt_xxx(get_current_clk_freq_by_table, 0, smu, clk_type, value)
+#define smu_thermal_temperature_range_update(smu, range, rw)           smu=
_ppt_xxx(thermal_temperature_range_update, 0, smu, range, rw)
+#define smu_get_thermal_temperature_range(smu, range)                  smu=
_ppt_xxx(get_thermal_temperature_range, 0, smu, range)
+#define smu_register_irq_handler(smu)                                  smu=
_ppt_xxx(register_irq_handler, 0, smu)
+#define smu_get_dpm_ultimate_freq(smu, param, min, max)                   =
     smu_ppt_xxx(get_dpm_ultimate_freq, 0, smu, param, min, max)
+#define smu_asic_set_performance_level(smu, level)                     smu=
_ppt_xxx(set_performance_level, -EINVAL, smu, level)
+#define smu_dump_pptable(smu)                                          smu=
_ppt_xxx(dump_pptable, 0, smu)
+#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)           =
     smu_ppt_xxx(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, fr=
eq)
+#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)       smu=
_ppt_xxx(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
+#define smu_override_pcie_parameters(smu)                              smu=
_ppt_xxx(override_pcie_parameters, 0, smu)
+#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)  smu=
_ppt_xxx(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
+#define smu_set_thermal_range(smu, range)                              smu=
_ppt_xxx(set_thermal_range, 0, smu, range)
+#define smu_disable_umc_cdr_12gbps_workaround(smu)                     smu=
_ppt_xxx(disable_umc_cdr_12gbps_workaround, 0, smu)
+#define smu_set_power_source(smu, power_src)                           smu=
_ppt_xxx(set_power_source, 0, smu, power_src)
+#define smu_i2c_eeprom_init(smu, control)                              smu=
_ppt_xxx(i2c_eeprom_init, 0, smu, control)
+#define smu_i2c_eeprom_fini(smu, control)                              smu=
_ppt_xxx(i2c_eeprom_fini, 0, smu, control)
+#define smu_get_unique_id(smu)                                         smu=
_ppt_xxx(get_unique_id, 0, smu)
+#define smu_log_thermal_throttling(smu)                                   =
     smu_ppt_xxx(log_thermal_throttling_event, 0, smu)
+#define smu_get_asic_power_limits(smu)                                 smu=
_ppt_xxx(get_power_limit, 0, smu)
 #define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_m=
ask) \
-       ((smu)->ppt_funcs->get_profiling_clk_mask ? (smu)->ppt_funcs->get_p=
rofiling_clk_mask((smu), (level), (sclk_mask), (mclk_mask), (soc_mask)) : 0=
)
-#define smu_set_cpu_power_state(smu) \
-       ((smu)->ppt_funcs->set_cpu_power_state ? (smu)->ppt_funcs->set_cpu_=
power_state((smu)) : 0)
-
-#define smu_msg_get_index(smu, msg) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_msg_index? (smu)->ppt=
_funcs->get_smu_msg_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_clk_get_index(smu, msg) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_clk_index? (smu)->ppt=
_funcs->get_smu_clk_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_feature_get_index(smu, msg) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_feature_index? (smu)-=
>ppt_funcs->get_smu_feature_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_table_get_index(smu, tab) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_table_index? (smu)->p=
pt_funcs->get_smu_table_index((smu), (tab)) : -EINVAL) : -EINVAL)
-#define smu_power_get_index(smu, src) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_power_index? (smu)->p=
pt_funcs->get_smu_power_index((smu), (src)) : -EINVAL) : -EINVAL)
-#define smu_workload_get_type(smu, profile) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_workload_type? (smu)->ppt=
_funcs->get_workload_type((smu), (profile)) : -EINVAL) : -EINVAL)
-#define smu_run_btc(smu) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->run_btc? (smu)->ppt_funcs->ru=
n_btc((smu)) : 0) : 0)
-#define smu_get_allowed_feature_mask(smu, feature_mask, num) \
-       ((smu)->ppt_funcs? ((smu)->ppt_funcs->get_allowed_feature_mask? (sm=
u)->ppt_funcs->get_allowed_feature_mask((smu), (feature_mask), (num)) : 0) =
: 0)
-
-
-#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis) \
-       ((smu)->ppt_funcs->store_cc6_data ? (smu)->ppt_funcs->store_cc6_dat=
a((smu), (st), (cc6_dis), (pst_dis), (pst_sw_dis)) : 0)
-
-#define smu_get_dal_power_level(smu, clocks) \
-       ((smu)->ppt_funcs->get_dal_power_level ? (smu)->ppt_funcs->get_dal_=
power_level((smu), (clocks)) : 0)
-#define smu_get_perf_level(smu, designation, level) \
-       ((smu)->ppt_funcs->get_perf_level ? (smu)->ppt_funcs->get_perf_leve=
l((smu), (designation), (level)) : 0)
-#define smu_get_current_shallow_sleep_clocks(smu, clocks) \
-       ((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_fu=
ncs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
-
-#define smu_dpm_set_vcn_enable(smu, enable) \
-       ((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_v=
cn_enable((smu), (enable)) : 0)
-#define smu_dpm_set_jpeg_enable(smu, enable) \
-       ((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_=
jpeg_enable((smu), (enable)) : 0)
-
-#define smu_set_watermarks_table(smu, tab, clock_ranges) \
-       ((smu)->ppt_funcs->set_watermarks_table ? (smu)->ppt_funcs->set_wat=
ermarks_table((smu), (tab), (clock_ranges)) : 0)
-#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \
-       ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs=
->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
-#define smu_thermal_temperature_range_update(smu, range, rw) \
-       ((smu)->ppt_funcs->thermal_temperature_range_update? (smu)->ppt_fun=
cs->thermal_temperature_range_update((smu), (range), (rw)) : 0)
-#define smu_get_thermal_temperature_range(smu, range) \
-       ((smu)->ppt_funcs->get_thermal_temperature_range? (smu)->ppt_funcs-=
>get_thermal_temperature_range((smu), (range)) : 0)
-#define smu_register_irq_handler(smu) \
-       ((smu)->ppt_funcs->register_irq_handler ? (smu)->ppt_funcs->registe=
r_irq_handler(smu) : 0)
-
-#define smu_get_dpm_ultimate_freq(smu, param, min, max) \
-               ((smu)->ppt_funcs->get_dpm_ultimate_freq ? (smu)->ppt_funcs=
->get_dpm_ultimate_freq((smu), (param), (min), (max)) : 0)
-
-#define smu_asic_set_performance_level(smu, level) \
-       ((smu)->ppt_funcs->set_performance_level? (smu)->ppt_funcs->set_per=
formance_level((smu), (level)) : -EINVAL);
-#define smu_dump_pptable(smu) \
-       ((smu)->ppt_funcs->dump_pptable ? (smu)->ppt_funcs->dump_pptable((s=
mu)) : 0)
-#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \
-               ((smu)->ppt_funcs->get_dpm_clk_limited ? (smu)->ppt_funcs->=
get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVAL)
-
-#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \
-               ((smu)->ppt_funcs->set_soft_freq_limited_range ? (smu)->ppt=
_funcs->set_soft_freq_limited_range((smu), (clk_type), (min), (max)) : -EIN=
VAL)
-
-#define smu_override_pcie_parameters(smu) \
-               ((smu)->ppt_funcs->override_pcie_parameters ? (smu)->ppt_fu=
ncs->override_pcie_parameters((smu)) : 0)
-
-#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
-               ((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_func=
s->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
-
-#define smu_set_thermal_range(smu, range) \
-               ((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->se=
t_thermal_range((smu), (range)) : 0)
-
-#define smu_disable_umc_cdr_12gbps_workaround(smu) \
-       ((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_f=
uncs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
-
-#define smu_set_power_source(smu, power_src) \
-       ((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_s=
ource((smu), (power_src)) : 0)
-
-#define smu_i2c_eeprom_init(smu, control) \
-               ((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_=
eeprom_init((smu), (control)) : 0)
-#define smu_i2c_eeprom_fini(smu, control) \
-               ((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_=
eeprom_fini((smu), (control)) : 0)
-#define smu_get_unique_id(smu) \
-               ((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_un=
ique_id((smu)) : 0)
-
-#define smu_log_thermal_throttling(smu) \
-               ((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->pp=
t_funcs->log_thermal_throttling_event((smu)) : 0)
+       smu_ppt_xxx(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_=
mask, soc_mask)

-#define smu_get_asic_power_limits(smu) \
-               ((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_=
power_limit((smu)) : 0)

 #endif
--
2.17.1

--_000_MN2PR12MB302299A4E004E950DB0B5553A29D0MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>yes, i can rename the marco &quot;smu_ppt_xxx&quot; to &quot;smu_ppt_f=
uns&quot;.</div>
<div>but in kernel code, we can see the same code style, likes:</div>
<div>path: //include/linux/cred.h<br>
</div>
<span></span>
<div>#define task_cred_xxx(task, xxx) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
</div>
<div>({ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; __typeof__(((struct cred *)NULL)-&gt;xxx) =
___val; &nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; rcu_read_lock(); &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; ___val =3D __task_cred((task))-&gt;xxx; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; rcu_read_unlock(); &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; ___val; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; \<br>
</div>
<div>})<br>
</div>
<div><br>
</div>
<div>#define task_uid(task) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(task_cred_xx=
x((task), uid))<br>
</div>
<div>#define task_euid(task) &nbsp; &nbsp; &nbsp; &nbsp; (task_cred_xxx((ta=
sk), euid))<br>
</div>
<div><br>
</div>
<div>#define current_cred_xxx(xxx) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; \<br>
</div>
<div>({ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;\<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; current_cred()-&gt;xxx; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\<br>
</div>
<div>})<br>
</div>
<div><br>
</div>
<div>#define current_uid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (current_cred=
_xxx(uid))<br>
</div>
<div>#define current_gid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (current_cred=
_xxx(gid))<br>
</div>
<div>#define current_euid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(current_cred=
_xxx(euid))<br>
</div>
<div>#define current_egid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(current_cred=
_xxx(egid))<br>
</div>
<div>#define current_suid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(current_cred=
_xxx(suid))<br>
</div>
<div>#define current_sgid() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(current_cred=
_xxx(sgid))<br>
</div>
<div>#define current_fsuid() &nbsp; &nbsp; &nbsp; &nbsp; (current_cred_xxx(=
fsuid))<br>
</div>
<div>#define current_fsgid() &nbsp; &nbsp; &nbsp; &nbsp; (current_cred_xxx(=
fsgid))<br>
</div>
<div>#define current_cap() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (current_cred=
_xxx(cap_effective))<br>
</div>
<div>#define current_user() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(current_cred=
_xxx(user))<br>
</div>
<span></span>
<div><br>
</div>
<div>anyway, i will send a new patch to correct it.</div>
<div>thanks.</div>
<div><br>
</div>
<span></span>Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 16, 2020 6:03 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
The naming style smu_ppt_xxx makes me confusing..... at first glance, I tho=
ught you just have some dummy code or the patch is something still working =
in progress. It would be better to rename it to smu_ppt_funcs.
<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
Sent: Tuesday, June 16, 2020 15:06<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<=
br>
Subject: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos<br>
<br>
add the new macro &quot;smu_ppt_xxx()&quot; to unify smu callback interface=
s<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_internal.h | 266 &#43;&#43;&#43;&#4=
3;&#43;&#43;-------------<br>
&nbsp;1 file changed, 82 insertions(&#43;), 184 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h<br>
index 880ef54884f8..0f9841bcdcb8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
@@ -25,191 &#43;25,89 @@<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;<br>
-#define smu_init_microcode(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;init_microco=
de ? (smu)-&gt;ppt_funcs-&gt;init_microcode((smu)) : 0)<br>
-#define smu_fini_microcode(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;fini_microco=
de ? (smu)-&gt;ppt_funcs-&gt;fini_microcode((smu)) : 0)<br>
-#define smu_init_smc_tables(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;init_smc_tab=
les ? (smu)-&gt;ppt_funcs-&gt;init_smc_tables((smu)) : 0)<br>
-#define smu_fini_smc_tables(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;fini_smc_tab=
les ? (smu)-&gt;ppt_funcs-&gt;fini_smc_tables((smu)) : 0)<br>
-#define smu_init_power(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;init_power ?=
 (smu)-&gt;ppt_funcs-&gt;init_power((smu)) : 0)<br>
-#define smu_fini_power(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;fini_power ?=
 (smu)-&gt;ppt_funcs-&gt;fini_power((smu)) : 0)<br>
-<br>
-#define smu_setup_pptable(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;setup_pptabl=
e ? (smu)-&gt;ppt_funcs-&gt;setup_pptable((smu)) : 0)<br>
-#define smu_powergate_sdma(smu, gate) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;powergate_sd=
ma ? (smu)-&gt;ppt_funcs-&gt;powergate_sdma((smu), (gate)) : 0)<br>
-<br>
-#define smu_get_vbios_bootup_values(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_vbios_bo=
otup_values ? (smu)-&gt;ppt_funcs-&gt;get_vbios_bootup_values((smu)) : 0)<b=
r>
-#define smu_check_fw_version(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;check_fw_ver=
sion ? (smu)-&gt;ppt_funcs-&gt;check_fw_version((smu)) : 0)<br>
-#define smu_write_pptable(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;write_pptabl=
e ? (smu)-&gt;ppt_funcs-&gt;write_pptable((smu)) : 0)<br>
-#define smu_set_min_dcef_deep_sleep(smu, clk) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_min_dcef=
_deep_sleep ? (smu)-&gt;ppt_funcs-&gt;set_min_dcef_deep_sleep((smu), (clk))=
 : 0)<br>
-#define smu_set_driver_table_location(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_driver_t=
able_location ? (smu)-&gt;ppt_funcs-&gt;set_driver_table_location((smu)) : =
0)<br>
-#define smu_set_tool_table_location(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_tool_tab=
le_location ? (smu)-&gt;ppt_funcs-&gt;set_tool_table_location((smu)) : 0)<b=
r>
-#define smu_notify_memory_pool_location(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;notify_memor=
y_pool_location ? (smu)-&gt;ppt_funcs-&gt;notify_memory_pool_location((smu)=
) : 0)<br>
-#define smu_gfx_off_control(smu, enable) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;gfx_off_cont=
rol ? (smu)-&gt;ppt_funcs-&gt;gfx_off_control((smu), (enable)) : 0)<br>
-<br>
-#define smu_set_last_dcef_min_deep_sleep_clk(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_last_dce=
f_min_deep_sleep_clk ? (smu)-&gt;ppt_funcs-&gt;set_last_dcef_min_deep_sleep=
_clk((smu)) : 0)<br>
-#define smu_system_features_control(smu, en) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;system_featu=
res_control ? (smu)-&gt;ppt_funcs-&gt;system_features_control((smu), (en)) =
: 0)<br>
-#define smu_init_max_sustainable_clocks(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;init_max_sus=
tainable_clocks ? (smu)-&gt;ppt_funcs-&gt;init_max_sustainable_clocks((smu)=
) : 0)<br>
-#define smu_set_default_od_settings(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_default_=
od_settings ? (smu)-&gt;ppt_funcs-&gt;set_default_od_settings((smu)) : 0)<b=
r>
-<br>
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;send_smc_msg=
_with_param? (smu)-&gt;ppt_funcs-&gt;send_smc_msg_with_param((smu), (msg), =
(param), (read_arg)) : 0)<br>
-<br>
-static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_messa=
ge_type msg, uint32_t *read_arg) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_with_param(sm=
u, msg, 0, read_arg);<br>
-}<br>
-<br>
-#define smu_alloc_dpm_context(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;alloc_dpm_co=
ntext ? (smu)-&gt;ppt_funcs-&gt;alloc_dpm_context((smu)) : 0)<br>
-#define smu_init_display_count(smu, count) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;init_display=
_count ? (smu)-&gt;ppt_funcs-&gt;init_display_count((smu), (count)) : 0)<br=
>
-#define smu_feature_set_allowed_mask(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_allowed_=
mask? (smu)-&gt;ppt_funcs-&gt;set_allowed_mask((smu)) : 0)<br>
-#define smu_feature_get_enabled_mask(smu, mask, num) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_enabled_=
mask? (smu)-&gt;ppt_funcs-&gt;get_enabled_mask((smu), (mask), (num)) : 0)<b=
r>
-#define smu_is_dpm_running(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;is_dpm_runni=
ng ? (smu)-&gt;ppt_funcs-&gt;is_dpm_running((smu)) : 0)<br>
-#define smu_notify_display_change(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;notify_displ=
ay_change? (smu)-&gt;ppt_funcs-&gt;notify_display_change((smu)) : 0)<br>
-#define smu_set_default_dpm_table(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_default_=
dpm_table ? (smu)-&gt;ppt_funcs-&gt;set_default_dpm_table((smu)) : 0)<br>
-#define smu_populate_umd_state_clk(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;populate_umd=
_state_clk ? (smu)-&gt;ppt_funcs-&gt;populate_umd_state_clk((smu)) : 0)<br>
-#define smu_set_default_od8_settings(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_default_=
od8_settings ? (smu)-&gt;ppt_funcs-&gt;set_default_od8_settings((smu)) : 0)=
<br>
-<br>
-#define smu_get_current_clk_freq(smu, clk_id, value) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_current_=
clk_freq? (smu)-&gt;ppt_funcs-&gt;get_current_clk_freq((smu), (clk_id), (va=
lue)) : 0)<br>
-<br>
-#define smu_tables_init(smu, tab) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;tables_init =
? (smu)-&gt;ppt_funcs-&gt;tables_init((smu), (tab)) : 0)<br>
-#define smu_set_thermal_fan_table(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_thermal_=
fan_table ? (smu)-&gt;ppt_funcs-&gt;set_thermal_fan_table((smu)) : 0)<br>
-#define smu_enable_thermal_alert(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;enable_therm=
al_alert? (smu)-&gt;ppt_funcs-&gt;enable_thermal_alert((smu)) : 0)<br>
-#define smu_disable_thermal_alert(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;disable_ther=
mal_alert? (smu)-&gt;ppt_funcs-&gt;disable_thermal_alert((smu)) : 0)<br>
-<br>
-#define smu_smc_read_sensor(smu, sensor, data, size) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;read_sensor?=
 (smu)-&gt;ppt_funcs-&gt;read_sensor((smu), (sensor), (data), (size)) : -EI=
NVAL)<br>
-<br>
-#define smu_pre_display_config_changed(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;pre_display_=
config_changed ? (smu)-&gt;ppt_funcs-&gt;pre_display_config_changed((smu)) =
: 0)<br>
-#define smu_display_config_changed(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;display_conf=
ig_changed ? (smu)-&gt;ppt_funcs-&gt;display_config_changed((smu)) : 0)<br>
-#define smu_apply_clocks_adjust_rules(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;apply_clocks=
_adjust_rules ? (smu)-&gt;ppt_funcs-&gt;apply_clocks_adjust_rules((smu)) : =
0)<br>
-#define smu_notify_smc_display_config(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;notify_smc_d=
isplay_config ? (smu)-&gt;ppt_funcs-&gt;notify_smc_display_config((smu)) : =
0)<br>
-#define smu_force_dpm_limit_value(smu, highest) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;force_dpm_li=
mit_value ? (smu)-&gt;ppt_funcs-&gt;force_dpm_limit_value((smu), (highest))=
 : 0)<br>
-#define smu_unforce_dpm_levels(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;unforce_dpm_=
levels ? (smu)-&gt;ppt_funcs-&gt;unforce_dpm_levels((smu)) : 0)<br>
&#43;#define smu_ppt_xxx(intf, ret, smu, args...) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs ? ((smu)-&gt=
;ppt_funcs-&gt;intf ? (smu)-&gt;ppt_funcs-&gt;intf(smu, ##args) : ret) : -E=
INVAL)<br>
&#43;<br>
&#43;#define smu_init_microcode(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; smu_ppt_xxx(init_microcode, 0, smu)<br>
&#43;#define smu_fini_microcode(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; smu_ppt_xxx(fini_microcode, 0, smu)<br>
&#43;#define smu_init_smc_tables(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(init_smc_tables, 0, sm=
u)<br>
&#43;#define smu_fini_smc_tables(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(fini_smc_tables, 0, sm=
u)<br>
&#43;#define smu_init_power(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(init_power, 0, smu)<br>
&#43;#define smu_fini_power(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(fini_power, 0, smu)<br>
&#43;#define smu_setup_pptable(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(setup_pptabl=
e, 0, smu)<br>
&#43;#define smu_powergate_sdma(smu, gate)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(powergate_sdma, 0, smu, gate)<br>
&#43;#define smu_get_vbios_bootup_values(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_ppt_xxx(get_vbios_bootup_values, 0, smu)<br>
&#43;#define smu_check_fw_version(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(check_fw_version, 0, smu)<b=
r>
&#43;#define smu_write_pptable(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(write_pptabl=
e, 0, smu)<br>
&#43;#define smu_set_min_dcef_deep_sleep(smu, clk)&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_min_dcef=
_deep_sleep, 0, smu, clk)<br>
&#43;#define smu_set_driver_table_location(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(set_driver_table_location, 0, smu)<br>
&#43;#define smu_set_tool_table_location(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_ppt_xxx(set_tool_table_location, 0, smu)<br>
&#43;#define smu_notify_memory_pool_location(smu)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(notify_=
memory_pool_location, 0, smu)<br>
&#43;#define smu_gfx_off_control(smu, enable)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_ppt_xxx(gfx_off_control, 0, smu, enable)<br>
&#43;#define smu_set_last_dcef_min_deep_sleep_clk(smu)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_last_dcef_min_deep_sleep_clk=
, 0, smu)<br>
&#43;#define smu_system_features_control(smu, en)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(system_=
features_control, 0, smu, en)<br>
&#43;#define smu_init_max_sustainable_clocks(smu)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(init_ma=
x_sustainable_clocks, 0, smu)<br>
&#43;#define smu_set_default_od_settings(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_ppt_xxx(set_default_od_settings, 0, smu)<br>
&#43;#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(send_smc_msg_with_para=
m, 0, smu, msg, param, read_arg)<br>
&#43;#define smu_send_smc_msg(smu, msg, read_arg)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(send_sm=
c_msg_with_param, 0, smu, msg, 0, read_arg)<br>
&#43;#define smu_alloc_dpm_context(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(alloc_dpm_context, 0, smu)<br>
&#43;#define smu_init_display_count(smu, count)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(init_display_count, 0, smu, count)<br>
&#43;#define smu_feature_set_allowed_mask(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(set_allowed_mask, 0, smu)<br>
&#43;#define smu_feature_get_enabled_mask(smu, mask, num)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(get_enabled_mask, 0, smu, mask, num)<br>
&#43;#define smu_is_dpm_running(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; smu_ppt_xxx(is_dpm_running, 0 , smu)<br>
&#43;#define smu_notify_display_change(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(notify_display_change, 0, smu)<br>
&#43;#define smu_set_default_dpm_table(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(set_default_dpm_table, 0, smu)<br>
&#43;#define smu_populate_umd_state_clk(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(populate_=
umd_state_clk, 0, smu)<br>
&#43;#define smu_set_default_od8_settings(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(set_default_od8_settings, 0, smu)<br>
&#43;#define smu_get_current_clk_freq(smu, clk_id, value)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(get_current_clk_freq, 0, smu, clk_id, value)<br=
>
&#43;#define smu_tables_init(smu, tab)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(tables_init, 0, smu, tab)<b=
r>
&#43;#define smu_set_thermal_fan_table(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(set_thermal_fan_table, 0, smu)<br>
&#43;#define smu_enable_thermal_alert(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(enable_thermal_alert, 0, smu)<br>
&#43;#define smu_disable_thermal_alert(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(disable_thermal_alert, 0, smu)<br>
&#43;#define smu_smc_read_sensor(smu, sensor, data, size)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(read_sensor, -EINVAL, smu, sensor, data, size)<=
br>
&#43;#define smu_pre_display_config_changed(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(pr=
e_display_config_changed, 0, smu)<br>
&#43;#define smu_display_config_changed(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(display_c=
onfig_changed, 0 , smu)<br>
&#43;#define smu_apply_clocks_adjust_rules(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(apply_clocks_adjust_rules, 0, smu)<br>
&#43;#define smu_notify_smc_display_config(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(notify_smc_display_config, 0, smu)<br>
&#43;#define smu_force_dpm_limit_value(smu, highest)&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; smu_ppt_xxx(force_dpm_limit_value, 0, smu, highest)<br>
&#43;#define smu_unforce_dpm_levels(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(unforce_dpm_levels, 0, smu)<br>
&#43;#define smu_set_cpu_power_state(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_cpu_power_state, 0, smu)<br>
&#43;#define smu_msg_get_index(smu, msg)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_smu_msg_index, -EINVAL, smu, msg)=
<br>
&#43;#define smu_clk_get_index(smu, clk)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_smu_clk_index, -EINVAL, smu, clk)=
<br>
&#43;#define smu_feature_get_index(smu, fea)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_smu_f=
eature_index, -EINVAL, smu, fea)<br>
&#43;#define smu_table_get_index(smu, tab)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(get_smu_table_index, -EINVAL, smu, tab)<br>
&#43;#define smu_power_get_index(smu, src)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, src)<br>
&#43;#define smu_workload_get_type(smu, type)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, type)<br>
&#43;#define smu_run_btc(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; smu_ppt_xxx(run_btc, 0, smu)<br>
&#43;#define smu_get_allowed_feature_mask(smu, feature_mask, num)&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_allowed_=
feature_mask, 0, smu, feature_mask, num)<br>
&#43;#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(store_cc6_data, 0, smu, st, cc6_dis, =
pst_dis, pst_sw_dis)<br>
&#43;#define smu_get_dal_power_level(smu, clocks)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_dal=
_power_level, 0, smu, clocks)<br>
&#43;#define smu_get_perf_level(smu, designation, level)&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_perf_level, 0, smu, designation, level=
)<br>
&#43;#define smu_get_current_shallow_sleep_clocks(smu, clocks)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_x=
xx(get_current_shallow_sleep_clocks, 0, smu, clocks)<br>
&#43;#define smu_dpm_set_vcn_enable(smu, enable)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(dp=
m_set_vcn_enable, 0, smu, enable)<br>
&#43;#define smu_dpm_set_jpeg_enable(smu, enable)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(dpm_set=
_jpeg_enable, 0, smu, enable)<br>
&#43;#define smu_set_watermarks_table(smu, tab, clock_ranges)&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(set_watermarks_table, 0, smu, tab, clock_ranges)<br>
&#43;#define smu_get_current_clk_freq_by_table(smu, clk_type, value)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; smu_ppt_xxx(get_current_clk_freq_by_table, 0, smu, clk_type, value=
)<br>
&#43;#define smu_thermal_temperature_range_update(smu, range, rw)&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(thermal_temp=
erature_range_update, 0, smu, range, rw)<br>
&#43;#define smu_get_thermal_temperature_range(smu, range)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(get_thermal_temperature_range, 0, smu, range)<br>
&#43;#define smu_register_irq_handler(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_ppt_xxx(register_irq_handler, 0, smu)<br>
&#43;#define smu_get_dpm_ultimate_freq(smu, param, min, max)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_dpm_ultima=
te_freq, 0, smu, param, min, max)<br>
&#43;#define smu_asic_set_performance_level(smu, level)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_performance_level, -EINVAL, smu, =
level)<br>
&#43;#define smu_dump_pptable(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(dump_pp=
table, 0, smu)<br>
&#43;#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; smu_ppt_xxx(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level=
, freq)<br>
&#43;#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_soft_freq_limited_range, -EI=
NVAL, smu, clk_type, min, max)<br>
&#43;#define smu_override_pcie_parameters(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(override_pcie_parameters, 0, smu)<br>
&#43;#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)&=
nbsp; smu_ppt_xxx(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_=
cap)<br>
&#43;#define smu_set_thermal_range(smu, range)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(set_thermal_range, 0, smu, range)<br>
&#43;#define smu_disable_umc_cdr_12gbps_workaround(smu)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(disable_umc_cdr_12gbps_workaround, 0,=
 smu)<br>
&#43;#define smu_set_power_source(smu, power_src)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(set_pow=
er_source, 0, smu, power_src)<br>
&#43;#define smu_i2c_eeprom_init(smu, control)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(i2c_eeprom_init, 0, smu, control)<br>
&#43;#define smu_i2c_eeprom_fini(smu, control)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
ppt_xxx(i2c_eeprom_fini, 0, smu, control)<br>
&#43;#define smu_get_unique_id(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_unique_i=
d, 0, smu)<br>
&#43;#define smu_log_thermal_throttling(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(log_therm=
al_throttling_event, 0, smu)<br>
&#43;#define smu_get_asic_power_limits(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_ppt_xxx(get_power_limit, 0, smu)<br>
&nbsp;#define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, =
soc_mask) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_profilin=
g_clk_mask ? (smu)-&gt;ppt_funcs-&gt;get_profiling_clk_mask((smu), (level),=
 (sclk_mask), (mclk_mask), (soc_mask)) : 0)<br>
-#define smu_set_cpu_power_state(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_cpu_powe=
r_state ? (smu)-&gt;ppt_funcs-&gt;set_cpu_power_state((smu)) : 0)<br>
-<br>
-#define smu_msg_get_index(smu, msg) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_smu_msg_index? (smu)-&gt;ppt_funcs-&gt;get_smu_msg_index((smu=
), (msg)) : -EINVAL) : -EINVAL)<br>
-#define smu_clk_get_index(smu, msg) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_smu_clk_index? (smu)-&gt;ppt_funcs-&gt;get_smu_clk_index((smu=
), (msg)) : -EINVAL) : -EINVAL)<br>
-#define smu_feature_get_index(smu, msg) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_smu_feature_index? (smu)-&gt;ppt_funcs-&gt;get_smu_feature_in=
dex((smu), (msg)) : -EINVAL) : -EINVAL)<br>
-#define smu_table_get_index(smu, tab) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_smu_table_index? (smu)-&gt;ppt_funcs-&gt;get_smu_table_index(=
(smu), (tab)) : -EINVAL) : -EINVAL)<br>
-#define smu_power_get_index(smu, src) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_smu_power_index? (smu)-&gt;ppt_funcs-&gt;get_smu_power_index(=
(smu), (src)) : -EINVAL) : -EINVAL)<br>
-#define smu_workload_get_type(smu, profile) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_workload_type? (smu)-&gt;ppt_funcs-&gt;get_workload_type((smu=
), (profile)) : -EINVAL) : -EINVAL)<br>
-#define smu_run_btc(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;run_btc? (smu)-&gt;ppt_funcs-&gt;run_btc((smu)) : 0) : 0)<br>
-#define smu_get_allowed_feature_mask(smu, feature_mask, num) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs? ((smu)-&gt;ppt_=
funcs-&gt;get_allowed_feature_mask? (smu)-&gt;ppt_funcs-&gt;get_allowed_fea=
ture_mask((smu), (feature_mask), (num)) : 0) : 0)<br>
-<br>
-<br>
-#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;store_cc6_da=
ta ? (smu)-&gt;ppt_funcs-&gt;store_cc6_data((smu), (st), (cc6_dis), (pst_di=
s), (pst_sw_dis)) : 0)<br>
-<br>
-#define smu_get_dal_power_level(smu, clocks) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_dal_powe=
r_level ? (smu)-&gt;ppt_funcs-&gt;get_dal_power_level((smu), (clocks)) : 0)=
<br>
-#define smu_get_perf_level(smu, designation, level) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_perf_lev=
el ? (smu)-&gt;ppt_funcs-&gt;get_perf_level((smu), (designation), (level)) =
: 0)<br>
-#define smu_get_current_shallow_sleep_clocks(smu, clocks) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_current_=
shallow_sleep_clocks ? (smu)-&gt;ppt_funcs-&gt;get_current_shallow_sleep_cl=
ocks((smu), (clocks)) : 0)<br>
-<br>
-#define smu_dpm_set_vcn_enable(smu, enable) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;dpm_set_vcn_=
enable ? (smu)-&gt;ppt_funcs-&gt;dpm_set_vcn_enable((smu), (enable)) : 0)<b=
r>
-#define smu_dpm_set_jpeg_enable(smu, enable) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;dpm_set_jpeg=
_enable ? (smu)-&gt;ppt_funcs-&gt;dpm_set_jpeg_enable((smu), (enable)) : 0)=
<br>
-<br>
-#define smu_set_watermarks_table(smu, tab, clock_ranges) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_watermar=
ks_table ? (smu)-&gt;ppt_funcs-&gt;set_watermarks_table((smu), (tab), (cloc=
k_ranges)) : 0)<br>
-#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_current_=
clk_freq_by_table ? (smu)-&gt;ppt_funcs-&gt;get_current_clk_freq_by_table((=
smu), (clk_type), (value)) : 0)<br>
-#define smu_thermal_temperature_range_update(smu, range, rw) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;thermal_temp=
erature_range_update? (smu)-&gt;ppt_funcs-&gt;thermal_temperature_range_upd=
ate((smu), (range), (rw)) : 0)<br>
-#define smu_get_thermal_temperature_range(smu, range) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_thermal_=
temperature_range? (smu)-&gt;ppt_funcs-&gt;get_thermal_temperature_range((s=
mu), (range)) : 0)<br>
-#define smu_register_irq_handler(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;register_irq=
_handler ? (smu)-&gt;ppt_funcs-&gt;register_irq_handler(smu) : 0)<br>
-<br>
-#define smu_get_dpm_ultimate_freq(smu, param, min, max) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_dpm_ultimate_freq ? (smu)-&gt;ppt_f=
uncs-&gt;get_dpm_ultimate_freq((smu), (param), (min), (max)) : 0)<br>
-<br>
-#define smu_asic_set_performance_level(smu, level) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_performa=
nce_level? (smu)-&gt;ppt_funcs-&gt;set_performance_level((smu), (level)) : =
-EINVAL);<br>
-#define smu_dump_pptable(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;dump_pptable=
 ? (smu)-&gt;ppt_funcs-&gt;dump_pptable((smu)) : 0)<br>
-#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_dpm_clk_limited ? (smu)-&gt;ppt_fun=
cs-&gt;get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVA=
L)<br>
-<br>
-#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_soft_freq_limited_range ? (smu)-&gt=
;ppt_funcs-&gt;set_soft_freq_limited_range((smu), (clk_type), (min), (max))=
 : -EINVAL)<br>
-<br>
-#define smu_override_pcie_parameters(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;override_pcie_parameters ? (smu)-&gt;pp=
t_funcs-&gt;override_pcie_parameters((smu)) : 0)<br>
-<br>
-#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;update_pcie_parameters ? (smu)-&gt;ppt_=
funcs-&gt;update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) :=
 0)<br>
-<br>
-#define smu_set_thermal_range(smu, range) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_thermal_range ? (smu)-&gt;ppt_funcs=
-&gt;set_thermal_range((smu), (range)) : 0)<br>
-<br>
-#define smu_disable_umc_cdr_12gbps_workaround(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;disable_umc_=
cdr_12gbps_workaround ? (smu)-&gt;ppt_funcs-&gt;disable_umc_cdr_12gbps_work=
around((smu)) : 0)<br>
-<br>
-#define smu_set_power_source(smu, power_src) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_power_so=
urce ? (smu)-&gt;ppt_funcs-&gt;set_power_source((smu), (power_src)) : 0)<br=
>
-<br>
-#define smu_i2c_eeprom_init(smu, control) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;i2c_eeprom_init ? (smu)-&gt;ppt_funcs-&=
gt;i2c_eeprom_init((smu), (control)) : 0)<br>
-#define smu_i2c_eeprom_fini(smu, control) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;i2c_eeprom_fini ? (smu)-&gt;ppt_funcs-&=
gt;i2c_eeprom_fini((smu), (control)) : 0)<br>
-#define smu_get_unique_id(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_unique_id ? (smu)-&gt;ppt_funcs-&gt=
;get_unique_id((smu)) : 0)<br>
-<br>
-#define smu_log_thermal_throttling(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;log_thermal_throttling_event ? (smu)-&g=
t;ppt_funcs-&gt;log_thermal_throttling_event((smu)) : 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_xxx(get_profiling_clk_mas=
k, 0, smu, level, sclk_mask, mclk_mask, soc_mask)<br>
&nbsp;<br>
-#define smu_get_asic_power_limits(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_power_limit ? (smu)-&gt;ppt_funcs-&=
gt;get_power_limit((smu)) : 0)<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB302299A4E004E950DB0B5553A29D0MN2PR12MB3022namp_--

--===============0563875517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0563875517==--
