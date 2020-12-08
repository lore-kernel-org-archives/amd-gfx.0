Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EDFC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 10:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C182207A0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 10:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C182207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4416E0C2;
	Tue,  8 Dec 2020 10:34:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8826E0C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 10:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcQ3xCgQLPhyXnirX7wYJAM1p7W70qEDKgPzwg0Z4XHqTxw9qUPYexZPEwDAbcAf0aZUF3/LXxlOW0kgKdQAv3J6OkyvV5ERPcgZFalpZ17fKwAy8GUk+m1QQX9+idvwFghy2W6cSgwUXqv2BYux8i6I3UBNV0m7SoX++ISW4R3F9zZtBpuNX8eIpReoudbL9ry9svkCrWTlRJZhzvOty1pIqHU3dFzsZZSEJi6X/XYidOhZbgPtFNpHf0vJ/mX7MdqQDoDW41FJT6BNgWcsDHH3zYxkQzMRzWMQGD0nfKynJiXu32YxBEn67GLg7e8iNX0vHgjcSnUhHmkv5W+OnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC68KOZzDF9PdY+wHEFimWUCwo2lHXxfQPheGKNPvCM=;
 b=TNYa2NAwMv6PWxW5COPGhwT/0T5yxzH9lMj47MHgDAAbVydjT0Az09yWnk9XY6gxRjj09R7BHTN1qKuQG/PcjQsO4LaLmH04+Iz2s11NGQOtWBSxe6LvD03BRnCAvZxwBxqPYZSDvFywMoupy8AmNRvGAmr3w68ZlXnwu8nMrSl8DHbhEXAILlrpTDhPtkm6I6GV8xOWqMQWLJgZE6kARJH29dkFaVgx4ttNLmE1dUyR1fZpHTsAUbEgcHfT+zQZ9dVV3YT5KAbtQGF7E5fyFKDSfb8ZsnfBS9eTLDJ/LU/VM7BTyLD7PRmgOUF139IO6DtMWcEGpzjSoLm0oEf13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC68KOZzDF9PdY+wHEFimWUCwo2lHXxfQPheGKNPvCM=;
 b=Ua8cI9OvqZw3rakMDMzJVjrgdOWzqVzca/s+wrzC35IfCCSQNcIpQTM1EVgwigQf4T8snAKUbwnZTlqMhtPldE5Pkc7o17p0+RMGjEfG32caR2/agL2DelR0NYaX0Mp6WQL8ilamXWfWQvI2r8TyjgeG5wd8HjnvmCubeEN40M8=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:44::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Tue, 8 Dec
 2020 10:33:56 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 10:33:56 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port
 workaround
Thread-Topic: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port
 workaround
Thread-Index: AQHWzTwT473GVtpjUEON5R4rNQpSk6ntAB4A
Date: Tue, 8 Dec 2020 10:33:56 +0000
Message-ID: <BL0PR12MB491323BEE3CC26D02DCBE01797CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
 <20201208082733.126647-5-evan.quan@amd.com>
In-Reply-To: <20201208082733.126647-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T10:33:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4ba5a513-f964-4fd6-b368-00001318a006;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-08T10:33:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0a844403-820d-4e50-a5bd-00002017c084
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T10:33:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ef018ff3-9816-4b4e-a795-000099355895
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27f20b76-78fd-4f96-08c0-08d89b64c430
x-ms-traffictypediagnostic: BL0PR12MB2354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2354DB6E2EF3A270CEE3C8CE97CD0@BL0PR12MB2354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2mMdNdpeUbBOFVelrj1txu808zQTpRHqhTQNT4TzhyTwItfBVEbmmGmKom8voR33tbBRuqSWjUXHo2IhOP8MD5J3zUkbqS5VTgOQ+dYgaT0SY+QFohE/6nT96u8qhY9fAwOt0xzciUSUTy6Shvr/QxYIoY0PmNOxEI8cfRG7g+6cGEzEo0+igas8qtjC5jR4aaYDQFGGWO8yEMLDHyFwkEFNDaowkavcqXQ0KfQ/Blv36oJpO/jCAxeZVLMQBHbXfA13Gxv8X/e09ImBqwZm51YspYY+gbcZydoxYyUQXcqgrimMcJEahrUqwuVWzi0wQYP52fgTPm0CtS6vHnEnWF/NV29T4qWVii1bQ/ch0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(52536014)(7696005)(4326008)(478600001)(966005)(83380400001)(9686003)(66946007)(45080400002)(66556008)(54906003)(66446008)(66476007)(71200400001)(110136005)(8676002)(76116006)(316002)(2906002)(64756008)(55016002)(8936002)(33656002)(5660300002)(186003)(6506007)(53546011)(26005)(86362001)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9MPZ8ik2jHb0WPT322P1YmxmDw7+dKpSdUuRZxm9BO8WOLKG1U0spaaGpAU2?=
 =?us-ascii?Q?6kilkQL58f7P1QtY7c7RCpg0HBTeIAvlOH57Wq8t2qYDURD0L8UfXJaOxq14?=
 =?us-ascii?Q?qNfOcRHQUVWOL+makP8MIhmJnm/o5LnsSVzBFAPjqM/vl7Qf0IZ+FU643DiO?=
 =?us-ascii?Q?3DdbMEFaJMli5Gw3HYaswR0g64lxVM1GPy/xCGvCqFNizCJFD2hpqbkF90ns?=
 =?us-ascii?Q?8pw7+EYXqxE4nWbZpjaCxSBpJHnqlS0IdS8ARwmJhs1I8p99ssszFxEmq6YO?=
 =?us-ascii?Q?PYyjV+qN4URhqFY6nMpHgrDxUXHqsx04j0mvdZRvdBi7SYQJyN0BqnjBaP66?=
 =?us-ascii?Q?jbU2to7yzIO/HjXl8jcVwZO4qy598KmpUgLOmHeKs+wGFXKiN7OfHGpr1GdS?=
 =?us-ascii?Q?Gpj8E9RF+3G/kzw5ndSnlMyMR02AAoGNiH2n0FbrVcaWE0o4L44F4Uy95/eM?=
 =?us-ascii?Q?VEvKHPaMPnNNYx9MjU1jcoa+ocOhBofcQ0R8kabsIdFHpVLEorAAOKYuInP5?=
 =?us-ascii?Q?ZmAydHsOJi1zbJGVXNolPu+BZdca/asjHwEhIVS82JVzIVukL3qniIiE8Rb7?=
 =?us-ascii?Q?Qo4hMutdNxbbRvVPzWs7dzWzx+OZMTf5b/PNC+O/NDlqhFpA8fP6Bpn2q/Zh?=
 =?us-ascii?Q?fi4edxdqG2PFbtCka5fVejd7v3es/eihSpqOV7GpCGKc5h8tYFoz9tQlmUnW?=
 =?us-ascii?Q?hc6E1dKGr+RCY7yJYYiUZX/YH5deO4nXhHGO6zAIKlXS+BJd+utM4EcoPcqx?=
 =?us-ascii?Q?/hykdyea//dDx+Ivao4HeJvkUCvdRjW7EhXJN2D8psWjX5YIGVmFn15MP3Es?=
 =?us-ascii?Q?lvBvl9Bpe1fFk6ynpImZHmXI1xTe9Z5WiG6r6bQtVUEK0KiRQFhfF2lAAxyQ?=
 =?us-ascii?Q?oslKvsGjPph8wnNNc243kRc9TFUZqRmEvLkP3D9qA87CRc/eZ8ws3tXc4NkI?=
 =?us-ascii?Q?wvLkyIlB8YRFi28bsCXtTgd7uldfbg+gpITjxKXNZrE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f20b76-78fd-4f96-08c0-08d89b64c430
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 10:33:56.2685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0HMQQtjV9IT7jMIvHQsvC6shwpUWikNvOFLin6NsKLbXHPyYz7VlYR6IRmZLgiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Rather than introduce this as a generic step in amdgpu_smu, confine the work around only to sienna cichlid. For ex: this may be done just before enabling dpm with system_features control override.

Thanks,
Lijo 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Tuesday, December 8, 2020 1:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port workaround

[CAUTION: External Email]

2nd usb2.0 port workaround wrapper.

Change-Id: I615d8a568b1f6623a060ba5081c2d2a1235f32b9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index cb96466605d5..3d6af881f507 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -601,6 +601,7 @@ struct pptable_funcs {
        int (*gpo_control)(struct smu_context *smu, bool enablement);
        int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
        int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
+       int (*notify_2nd_usb20_port)(struct smu_context *smu);
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e6ae722ca6e6..3515203df2c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -935,6 +935,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
                return ret;
        }

+       ret = smu_notify_2nd_usb20_port(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to notify 2nd usb2.0 port!\n");
+               return ret;
+       }
+
        ret = smu_set_driver_table_location(smu);
        if (ret) {
                dev_err(adev->dev, "Failed to SetDriverDramAddr!\n"); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 68d9464ababc..2eaec41dc808 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -91,6 +91,7 @@
 #define smu_post_init(smu)                                             smu_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)                               smu_ppt_funcs(gpo_control, 0, smu, enablement)
 #define smu_set_fine_grain_gfx_freq_parameters(smu)                                    smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
+#define smu_notify_2nd_usb20_port(smu)                                 smu_ppt_funcs(notify_2nd_usb20_port, 0, smu)

 #endif
 #endif
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4e916532c7584fc543d808d89b5334b5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430128956487556%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BnxEAwGyn7th3u271jiCPfsc03729IfZWvMpzGwhuWY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
