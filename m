Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D70C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 00:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C20510E380;
	Wed, 17 May 2023 00:33:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0724C89361
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 00:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNf/JYeL5rQ3gudnkX3Wri4B4SfsWje45rLjySf4nFkKaW81xQ0ijeRT5S35GZgCjdRLo2fbWFugiVTPDQeg+81rPdwgnk9DAaXZEIamjKdDqKUqq3BTXmG4pzi7/ffMw8TCeobUz71BFPuSTmEOnTaK0SKdQT9/ieJ/JvdaIn4RCTsUiyfqUZijC44xx0mSnr3ghGPE/siEPxlCCQQ8USCvkfVpQzn8xkHy0bgqeoT2vyV5XdC6hbsygi+nX20EbNxc3/5udqyUbbhA1y/CHYVc2QUyrMA7xefhPJbf4T5yAzLg3kXA+o8DdDUZC7jFEOteH/zT4BwhMG+KBDlQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6UW5fqr9W+hWdmQDD09zCporzNy2rBO2gXf7rIVqVA=;
 b=Y6FJA4xY8kp4cB34xpVMTT30a3mJwM7FpeB6lylF/12HPHCiU3mjlFir4C0jNFpCYOBlxFp0Vqa7L6vSHebEAvvj5UJeX7yFv6andHje5h0mngIQ/Tw9jo3jMZQX8g2EcZ9HAfxZuEiZF752AHsIEvoMRR+lWSzotAsPNYh1b1tpPgWX+4jVqELEHpVhX8u27ii6A+LV6BfG57ms0NESeqZRMdflnvJohhSNQKv2b8FS52gqjtZZdp36nIiyCcIsbrpChyhssAd/QQNx1QEKRTZ3FXUiZqQzb4iGvPSNfh5mYAq/ki1PoMVFbMyMKPxEr/ZkSrT9WMg44RBbRg1hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6UW5fqr9W+hWdmQDD09zCporzNy2rBO2gXf7rIVqVA=;
 b=Fz6XsJJ18hOQICItQicjhfp7dni7YYGK0MBZ8GhbrySjsN2Y3p/f5zz+Doy8n+LaFUwrYf4wYPZF9FcuKacQ9gB2a2jnfTC2Ze4SzcGRp4+2DeQINL6WPEExx0INNlVtgE/V86duPB3XJ95fJUi6lyPOFJhUiDHnSgxFMcBFW1s=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Wed, 17 May
 2023 00:33:19 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 00:33:19 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add delay to avoid unintened shutdown due to
 hotspot temperature spark
Thread-Topic: [PATCH] drm/amd/pm: add delay to avoid unintened shutdown due to
 hotspot temperature spark
Thread-Index: AQHZh6FlIV59ubMKbEGn7gw8OWx7YK9dnoDw
Date: Wed, 17 May 2023 00:33:19 +0000
Message-ID: <DM4PR12MB5165FD60D5F3F135AEB8548E8E7E9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230516025105.795595-1-evan.quan@amd.com>
In-Reply-To: <20230516025105.795595-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3347b2e5-2bb9-498a-9fd3-437fc9d40442;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T00:31:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SN7PR12MB7225:EE_
x-ms-office365-filtering-correlation-id: 056a104a-3e8c-4a64-cecb-08db566e502e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+Z6f1IA7zVEn0Y27EIVN//WH4c+H9kWrSX70PmnMu/qQQo729wnT2+lANPmKUxqrmw0HjUBHZb4cwpHHBKO6dJOsSOBOrB/h0osTR6y17W+m8ntxWwIwAN6uqKewC3PGkhYIqV0ZF2sjpwcg43BZXRud6zgr2m4QtHKdlTvKP+kbK5pBchtVXEVzohsrh2WOvHkFHrRib36AwyGn7K6oHZlEaB5+x5QOzKN9hnbIhwG0/wRoVIjRJZDT0RBAWJAjyEDdww07sy9l3OgJBJnS7AL4yjgsKF5Wmvy3gR9UXDvH8SyjX7Ata2V8lfzQDMIXewevtQUYpjYFihsiRv53SSqT+h+RPbtU52eSR3fhPTQf4D9HL2EyAq/tpSwk1wtXuwPT7PT82Ta9lZhL6wlSMAiVEcMgFtMBKUJqSEUaqxX1L6vhP56oOlENACzwJWoFo2qLKHaytIaUuWDcN+z7fa4ouVPfbCrkGSQxfBrm0Kz4URpkJ3eQtXzh9ycBiMczex2OM57ME6aOdwV2NymOQ0grvjhRrZsdYYmHNAbDhD5wgGiGUX/x8DuR3y4Gq4m49J3+2AQgcdY4SvPnYk34ndklk1lI6OMnS+5DZ7E9yh73Xbv9cWBjBBdgOdybR+b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(478600001)(110136005)(54906003)(64756008)(66556008)(66476007)(41300700001)(316002)(2906002)(71200400001)(4326008)(8936002)(8676002)(5660300002)(6506007)(76116006)(53546011)(186003)(26005)(9686003)(66446008)(83380400001)(7696005)(66946007)(122000001)(38100700002)(55016003)(38070700005)(52536014)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7xtReX4MBjbBO1rbjRauNieNxJ//7nMWZ6wZOWUcIr/D0qrwVNjEA/hBfoNS?=
 =?us-ascii?Q?FXqS5Gb/o29/6A9T56AiDd2KJTeiR5AJMwyeUBl17ag9PzmSOCZpTd6AS+2k?=
 =?us-ascii?Q?RxtP4yL5iUdrKVU4TyX1bpMbpokUeScC3hH5ZZYtB7zaYvA58rWPXXq5Gdq4?=
 =?us-ascii?Q?tVex6iJpYhVUpQGdrKiCNrUJpJuhwmAY/AomtR4iMikoT/ZDqtT/jyx6+DJ+?=
 =?us-ascii?Q?sQbBivyDmPONaF5WCEFnNLFVUHVybal0AlGdHfDk8o9fZZVeJ1e4KkGZgU0D?=
 =?us-ascii?Q?//59i9jGoBmwKAnWyZiYI+4mNRBrojvvxh5e3umHN7xQ4ujN+LeJ5iAWM3BD?=
 =?us-ascii?Q?qDv4StbmIHJ5hmjqZ47bIW8t34Mm/VNtFDb1LYunct0BGfJHVivhaooiHxTs?=
 =?us-ascii?Q?PtKXiLFKI/z4ThT1ATM3WBCq8ij3RIjRRSnEKTEwa0bFAX/e6OYp1BHSId0v?=
 =?us-ascii?Q?7L3lrxxsASkb1JeCxQRsKeX0TxqSfGvxnt0diII+q009BOsu0yZIpjFbOGlF?=
 =?us-ascii?Q?G/fLwI2Onr5UiTvKUAa7HlDZQ1HMrjxW+KZ9/gSWSE8Rsvg07GyOjdhcwgBo?=
 =?us-ascii?Q?eBEdoq2xOK+br6w5EarbKX9NqL0PY76KebIaclqDtsqS4oFj1vnYBXXF5v5q?=
 =?us-ascii?Q?OjP2nBJhFDUP1LPR7PCR7o0KzWvh0fSZcdjZpCRzQwIEXNal9SL0Ty7GCy2x?=
 =?us-ascii?Q?VWC83duXoVCuIHZTYBj36HPkAWFr8Is+wtO7jctkee31CWZI2EeR1mG1brdP?=
 =?us-ascii?Q?OAczMS0H8M9Ge5IBYKYPxARHkq5AaQDsextLKzNC0SyW6+VGDaJMV3inFm0g?=
 =?us-ascii?Q?BoSKF2u9Q9AXvLQTFKARIWT/FbXUqLbkdtjDX+WwVCZtKvSdD9SOTNHokjhB?=
 =?us-ascii?Q?nSORYN9kR2Fc4SrYC3r3VdvPaVJTdGogRyIPQAHzouG4KwvwmY95JGqUuMAF?=
 =?us-ascii?Q?kq0feAwmypJVMLGmJbxOqtROfmxLbrG/ISBRBd3Tu+STg3wnEGwz3tbpEB3A?=
 =?us-ascii?Q?BSfpe+nDKjV9gNgEQpnSOpazP9ukDhMQtTqJvsaZOcrXOrFl42iKQ+AKr0St?=
 =?us-ascii?Q?HUssSZpdusBVVWgPB1shq8nlSZhM0nrm6uBs+k8s75h9Ve2u6RaUyeWUIMzU?=
 =?us-ascii?Q?vAd7AdWHGdsMecblB2VaCFgDUSOHpP+a5npnpmPTmLXwbvmyBHdt7evmNDDY?=
 =?us-ascii?Q?qGibezD7IhW5kyv5dSzPsir1LFoeoF+RUff+AOPjkvv/ofe3iJ/lDj3SDVlK?=
 =?us-ascii?Q?DHSj9Xh6STp8kPp1Yn2SDMmNWpcCVIe8IoK28kStQXsXnG57+RM40bVwMyRs?=
 =?us-ascii?Q?Qjbmqtv90sKHwggEkvbxuqSKZ1aHSTbtu4BG4NIUKsvFxk9WT+jBFmcjjP+c?=
 =?us-ascii?Q?cxg+hZ7Ql7jj/uGFiwwkHrphDzW0Ul2zmez465EmIHBR+JSlJ2BNWzGdK3DM?=
 =?us-ascii?Q?oVFYbVSDNG32gBkH11jrdF9H/+OFuc6mlCZ/Y9He01yPEzXwTtZqtn30B6ls?=
 =?us-ascii?Q?dcwH3V0r9jovCF7fthu+56MqP/50L8z147A4mrNs2qsrzbHD5JFXy8NgCDZG?=
 =?us-ascii?Q?FLoxpFM7EZ47hWcO/Pk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056a104a-3e8c-4a64-cecb-08db566e502e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 00:33:19.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vo9HuXony2BVzEZ3mpqNkCytttNEtyxL5T5ek4liYOC1U4xHGaQJafiAQ7jwKyQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Do we really need this delay on all the ASICs?
Maybe set the default value to 0 is more reasonable?
Thanks.


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, May 16, 2023 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: add delay to avoid unintened shutdown due to h=
otspot temperature spark

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


There will be a double check for the hotspot temperature on delay expired. =
This can avoid unintended shutdown due to hotspot temperature spark.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - add the proper millidegree Celsius to degree Celsius transform
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ++---
 6 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 39192eba3ff8..4cd873659365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -243,6 +243,7 @@ extern int amdgpu_num_kcq;  #define AMDGPU_VCNFW_LOG_SI=
ZE (32 * 1024)  extern int amdgpu_vcnfw_log;  extern int amdgpu_sg_display;
+extern uint amdgpu_ctf_delay;

 #define AMDGPU_VM_MAX_NUM_CTX                  4096
 #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 749eeb9a2976..6c699fefdf92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -198,6 +198,7 @@ int amdgpu_smartshift_bias;  int amdgpu_use_xgmi_p2p =
=3D 1;  int amdgpu_vcnfw_log;  int amdgpu_sg_display =3D -1; /* auto */
+uint amdgpu_ctf_delay =3D 50; /* in ms */

 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work=
);

@@ -973,6 +974,19 @@ MODULE_PARM_DESC(smu_pptable_id,
        "specify pptable id to be used (-1 =3D auto(default) value, 0 =3D u=
se pptable from vbios, > 0 =3D soft pptable id)");  module_param_named(smu_=
pptable_id, amdgpu_smu_pptable_id, int, 0444);

+/**
+ * DOC: ctf_delay (uint)
+ * On SW CTF triggerred, to protect the chip from over-heated and
+possible damage, we usually
+ * trigger a system shutdown. However, considering there may be a
+hotspot temperature spark
+ * momentarily hitting the SW CTF setting point, a delay is added to avoid=
 unintended shutdown.
+ * On the delay expired, the shutdown will be performed if the hotspot
+temp is still
+ * bigger than the SW CTF setting. Otherwise, nothing will be done.
+ * The default setting for the delay is 50ms.
+ */
+MODULE_PARM_DESC(ctf_delay,
+               "the delay(default 50ms) enforced before real action
+taken on ctf triggerred"); module_param_named(ctf_delay,
+amdgpu_ctf_delay, uint, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 3c860939031e..71153b335ad9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -24,6 +24,7 @@

 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>

 #include "amdgpu.h"
 #include "amdgpu_smu.h"
@@ -1070,6 +1071,34 @@ static void smu_interrupt_work_fn(struct work_struct=
 *work)
                smu->ppt_funcs->interrupt_work(smu);
 }

+static void smu_swctf_delayed_work_handler(struct work_struct *work) {
+       struct smu_context *smu =3D
+               container_of(work, struct smu_context, swctf_delayed_work.w=
ork);
+       struct smu_temperature_range *range =3D
+                               &smu->thermal_range;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t hotspot_tmp, size;
+
+       /*
+        * If the hotspot temperature is confirmed as below SW CTF setting =
point
+        * after the delay enforced, nothing will be done.
+        * Otherwise, a graceful shutdown will be performed to prevent furt=
her damage.
+        */
+       if (smu->ppt_funcs->read_sensor &&
+           !smu->ppt_funcs->read_sensor(smu,
+                                        AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+                                        &hotspot_tmp,
+                                        &size) &&
+           range->software_shutdown_temp &&
+           hotspot_tmp / 1000 < range->software_shutdown_temp)
+               return;
+
+       dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) det=
ected!\n");
+       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU=
 SW CTF!\n");
+       orderly_poweroff(true);
+}
+
 static int smu_sw_init(void *handle)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@ -=
1358,6 +1387,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
                return ret;
        }

+       INIT_DELAYED_WORK(&smu->swctf_delayed_work,
+                         smu_swctf_delayed_work_handler);
+
        ret =3D smu_enable_thermal_alert(smu);
        if (ret) {
          dev_err(adev->dev, "Failed to enable thermal alert!\n"); @@ -1592=
,6 +1624,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
                return ret;
        }

+       cancel_delayed_work_sync(&smu->swctf_delayed_work);
+
        ret =3D smu_disable_dpms(smu);
        if (ret) {
                dev_err(adev->dev, "Fail to disable dpm features!\n"); diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/am=
d/pm/swsmu/inc/amdgpu_smu.h
index 4ce394903c07..18101ec0ae6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -573,6 +573,8 @@ struct smu_context
        u32 debug_param_reg;
        u32 debug_msg_reg;
        u32 debug_resp_reg;
+
+       struct delayed_work             swctf_delayed_work;
 };

 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index e1ef88ee1ed3..4c3c682bf7a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct amdgpu_devic=
e *adev,
        if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
                switch (src_id) {
                case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-                       dev_emerg(adev->dev, "ERROR: GPU over temperature r=
ange(SW CTF) detected!\n");
-                       /*
-                        * SW CTF just occurred.
-                        * Try to do a graceful shutdown to prevent further=
 damage.
-                        */
-                       dev_emerg(adev->dev, "ERROR: System is going to shu=
tdown due to GPU SW CTF!\n");
-                       orderly_poweroff(true);
+                       schedule_delayed_work(&smu->swctf_delayed_work,
+
+ msecs_to_jiffies(amdgpu_ctf_delay));
                break;
                case THM_11_0__SRCID__THM_DIG_THERM_H2L:
                        dev_emerg(adev->dev, "ERROR: GPU under temperature =
range detected\n"); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13=
_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0bc0a6e97b5a..a5447119d5f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1377,13 +1377,8 @@ static int smu_v13_0_irq_process(struct amdgpu_devic=
e *adev,
        if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
                switch (src_id) {
                case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-                       dev_emerg(adev->dev, "ERROR: GPU over temperature r=
ange(SW CTF) detected!\n");
-                       /*
-                        * SW CTF just occurred.
-                        * Try to do a graceful shutdown to prevent further=
 damage.
-                        */
-                       dev_emerg(adev->dev, "ERROR: System is going to shu=
tdown due to GPU SW CTF!\n");
-                       orderly_poweroff(true);
+                       schedule_delayed_work(&smu->swctf_delayed_work,
+
+ msecs_to_jiffies(amdgpu_ctf_delay));
                        break;
                case THM_11_0__SRCID__THM_DIG_THERM_H2L:
                        dev_emerg(adev->dev, "ERROR: GPU under temperature =
range detected\n");
--
2.34.1

