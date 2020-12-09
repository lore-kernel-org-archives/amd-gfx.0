Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B90C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E00F2389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E00F2389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5BF89BF5;
	Wed,  9 Dec 2020 04:20:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7FE89BF5
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H90heDFkLrxbiWmkUIGwoRhB0NwNdr1V97TbYuXYe7M9BTnjcQ72v0QQHGRTYJ8LVX2ELtEV0UQmDFmfceh5Cfw/BHYf6aPKCvk0mbLsgXGNdlyqXFeIxmkz/VoHwIjd4jqqO/oiyE76wrK1JOOk0MoL0tLdyqAtVSM9SZmuZMJ1a7enaj7xm9Tt4cJu7BsyH1oktHqdpushKyvgZiaW+rxRootVaM0jACli0WQBJIOFpgpYYSp5uQfWGD9uqbSx7oUtg3+/nAms5+quRnQKVwZ7xLRvhThiR8/CoWZhvra8cwXIdlmaj10LIS7EozvEvfmUKUF5v0CrkoDtQBx4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23efZcRWRCeMEsVEzbqi+ZIlF6bvGd4qbCfdZMhbiaM=;
 b=ilL6fGBYInWIho3muvJWeOQ5qRr8ECDu7c4O/6yAGp45yc8ZYPg1Jh2ETPyu/PBEbc+tYKqk+nafFtDZDoX70O+Lvx71JqLiLWulsgnN9jP5HqgHOkH42sGzRAcFYEU7yjERu7+GtZQfpaUtAodFtA6DtD7Qdmhkbpjcvwmr/1IJggb/vbuoUCvyEY9BdWWfJIpj+ahygmKdtPiqUtzUU44FychoNBRrzJ1lZHlkyqWl62/XvV6RnS/FkEnBbp2mqgVt9/hF9w2uk9aKSTnJEruW1C6Rkj+5M9r0nU41tY6GqHepyFLL6wb88jHkMiIgx9bzVKCRekK8epqNeILnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23efZcRWRCeMEsVEzbqi+ZIlF6bvGd4qbCfdZMhbiaM=;
 b=KdwTuNebGy/bfTpZh8+N3EqHZQQ1L1bmcXhuMMz0j+i1d459j0KJfirAvMu7w8+ucNiQVm+eXmOzSvCMn97jYKy8mwK5uOlL9MrU8lKV/jolzXnxBEBoBeLZcCm2Pe5wo9NB7j6eg5KG96gOsfaU3f+1RZHGuKAVnBo6x+g4cM0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:20:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:20:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port
 workaround
Thread-Topic: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port
 workaround
Thread-Index: AQHWzTwPpEYKozwPi0uraESXL52ty6ntAMoAgAEpw5A=
Date: Wed, 9 Dec 2020 04:20:21 +0000
Message-ID: <DM6PR12MB2619A08B4006205C077CC457E4CC0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
 <20201208082733.126647-5-evan.quan@amd.com>
 <BL0PR12MB491323BEE3CC26D02DCBE01797CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB491323BEE3CC26D02DCBE01797CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61b1b672-80f2-4fd5-c369-08d89bf9be66
x-ms-traffictypediagnostic: DM5PR1201MB2505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2505E3213614B354F59BA903E4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsTbEvpblLhhmQLss4dIkyUDAyjhub9NTQ9CmYZz50uk+GIBy6fPXMa5NVZamBd0YZnkJ/24xtUHIvB03RMvnWOqR9NXgGtLL1QqQ8v7fIN7W5bZ2Noxh3G4E9X0b+lZ6dFTmfk16S2FV+fRyqaiOkB2V+oH95Uu8RA8a91bmPM17hXgbZU+i9zYRhF7mJTydM9PvxIuIAzbnd4T1B2pjyg3z818qRxXIgCnx5uL/bP23RQN2eni0hQMn3QgQfykMLudBHLEWuUf4Lab+LUueZNqZKLAzsYc/3AB6eMOrRUQdijp+pmJAJkhllrEXvJme2Yj7yhbjtSrnJ44FaNkHqi/UUAJvhQ6ZKaLhQsSNaQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(52536014)(8936002)(7696005)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(6506007)(508600001)(186003)(8676002)(110136005)(45080400002)(83380400001)(26005)(86362001)(71200400001)(2906002)(966005)(55016002)(53546011)(33656002)(4326008)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0zCCbOIoyiyAJw/wluha2TBaKyN1Mm9s5LA4SbRBvkPtqqoYwQk6uXuM5fRz?=
 =?us-ascii?Q?iks+YYMLYwkkHRAQgId0P+xVtlOnXL+ZihvhwLSCLT8a3lmyviIxS1QBK3dJ?=
 =?us-ascii?Q?6kCstvb0YMLZ5W28fPEdzIz+zzYPzVYFRRubysTIferddaKWmUiQHMRGo2tQ?=
 =?us-ascii?Q?hR3Z9nrsYvTNMFRo4TVxA7/zpeyJR50jvAAtioO6UWBzlGSztvhZbfdvW1x3?=
 =?us-ascii?Q?l+qWBXjM4ceW8BsqUACis4p9QyMcjlM2Cp2ouf3OGxiekH/GeNFs4lhEm2Kn?=
 =?us-ascii?Q?iPYhYPbuxldORG4g/WLs+sMBS4gygtLWqM+srlVKvi3BKje1wd4R7xq9jsOQ?=
 =?us-ascii?Q?BS+4Hpbu5Wg4Kij16dk5ZVyIR+AGNxxWUR0cyUzr6A6e1yta93YWKbQIO4gx?=
 =?us-ascii?Q?GT0O/9uDcb7hL98h3S5EwbB3eqd3hFlv4sgc4aaZKczYOOtjNsDYvC00+KvY?=
 =?us-ascii?Q?zjRDB/Yl+D8Lv/bBqkvorEPR7grUWFNcCsTxeGnncCZDHJ8/07V1o+188RK3?=
 =?us-ascii?Q?wjtmD23eS9sJZweXj70u9e5XlnBBVrwalu8OaqXxqS418+EI3CrPDdYFXp1k?=
 =?us-ascii?Q?QGMUnpbrmIeeiWhGxKTgDhgCmWQzCfDHdhFE7OSLi0tQtpMNzuH0bulp2vPk?=
 =?us-ascii?Q?DM4X6lAYR85KOPWTZjIhPX4kGvDP2wHFzk/vnwwwm1h4Ut74gUnJmrtCaSeQ?=
 =?us-ascii?Q?rFRad6ZkcuCbwOWPbSsWD06q6JR3BKr0cfUgdDZsL2hzKAyyu/9XULi51EIJ?=
 =?us-ascii?Q?95Iq0Z24AUw/VgZ1XD22nqAzmYDdI29YPSno9nfP3430G0rWOWMML2Yb/WgP?=
 =?us-ascii?Q?ohawiQG7o6Ca6d8kq5VL80E2RW2iczP+xZGcoweHNKJ1kKZsaEhBKG5I1wP/?=
 =?us-ascii?Q?KB1xQCW73v6B4NZCrRe6q8dgG8UEaADcXKfUyY1T+/I6bX4DaflD8d1NoReY?=
 =?us-ascii?Q?TQ3ld4Tjs/yldmZMV+lLH4FVwuF5KCQObpDWS7Sghx4HPH+5e/ea9KfI1e68?=
 =?us-ascii?Q?PBbZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b1b672-80f2-4fd5-c369-08d89bf9be66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 04:20:21.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7KGbCuTAOuj6tm70RF8Qwlgp9U1x3oEmpYNSVOcTH2fvxACjKkbWr85/Pg2q6Rh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Addressed in the new patch series.

BR
Evan
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Tuesday, December 8, 2020 6:34 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port workaround

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
