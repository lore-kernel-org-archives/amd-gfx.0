Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13B9C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 13:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634A3113298;
	Fri,  3 Jun 2022 13:02:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19F4113298
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 13:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIheWqykdyMHQtgIXmNWGoTgvHe7LAPx/pe5oGGSzWsv+7NyYPolEUTXAhkKzwoR43sljMw7wRGDWJKwT5vemOCewB3lbsY9e8zmAlfs7YXV+MvQpd5rMuYZ4zr6jLJpYYYA9Trxno28uJJQ6SVRw1TG6RqUGCb/+552ipOuxnf7gl5A8VgQ7mz+AExf0iEKB4KN21dLIESnNugtbsmL43WvKw/GUlsdDF4neOtB5Xuu1pZfZIwV8F1fYaL3tP0EXLl9+KbM6Bv8BHc1aYHDOJfKpvG1zOH8qLSu3y7Hp62ldoNfLDHHOgrAwSBZN1bUfRYm3SkaXl8/Ij2TcrrCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+005mboxVYbACJ2X2UJ/yuRDu/TmfoFaB02ig5tVm7o=;
 b=isRn5j4ruXHF7r8oiIoStz4TlHY22U+stNwzeNpTVXqVZFtchkk4Inr6vRovdPrYiSzhvhOR7WW02DsO84jo5XYEaBvGvTaa/aoegyEdpBPOfM3NrV+fJxYqg8Yu2X84z11Ku7eNUrmr1bSn+PbuwpEeboSvuS955r26Qoij2C7mve73MeQkLNr/6d90RPppVrCL5EisQuwy7vvDZC34JLa61BxQS3LLt4or8bFuCsWc5f80FaekKeq/ErR3fQMMG5u+UPebAS3G3/zhr/SDGyCgU7KrNZAQYqUK0qjgw2SF0E42/o8tg7Vbu0sW6hQSE8PmvKcmqIyendM2NeTVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+005mboxVYbACJ2X2UJ/yuRDu/TmfoFaB02ig5tVm7o=;
 b=HdXjR7FpK84x9eQIeu4euVwgFNEFto2VpYUSU1mkP+dgi0YqPd/58ZOb+H/22iDp7FoE92LP3KvaMi3FzhvktZQYN29ZE0ZP8GUsjjOJvt2LZhdKQGhvK+WFZ5mOOZrSGPxjMIGVapjESjEyH72Wq6I94nl7tbnQw0pqqwTjZhY=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BY5PR12MB3907.namprd12.prod.outlook.com (2603:10b6:a03:1ad::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 13:02:21 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::91d2:84f7:f722:8dae]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::91d2:84f7:f722:8dae%5]) with mapi id 15.20.5293.013; Fri, 3 Jun 2022
 13:02:21 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: adding device coredump support
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: adding device coredump support
Thread-Index: AQHYdlkC6/nH2nIFJUuSzMDRj1v0LK09p3cA
Date: Fri, 3 Jun 2022 13:02:21 +0000
Message-ID: <MW4PR12MB56672B0064C7573AA4F1D2C4F2A19@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20220602081538.1652842-1-Amaranath.Somalapuram@amd.com>
 <20220602081538.1652842-2-Amaranath.Somalapuram@amd.com>
In-Reply-To: <20220602081538.1652842-2-Amaranath.Somalapuram@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7026ffe7-778b-4e42-fe13-08da45614be6
x-ms-traffictypediagnostic: BY5PR12MB3907:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3907DD55E940A5505EA9878FF2A19@BY5PR12MB3907.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjETV1H+MzdbzvBcanMPQDIGLbII1FHZaMU1iWPEbDeQ5neyNXW7SUIYB80oU0luN6SkfWw1/fjExuEVfRV+FUmRJGiri6dY2hxaNKYbk90CTV0CGRIKlMagfoTF02EksCwLp9jFVrJLLUZvVMpy8OzzfIm+17M+lfxIhJR9XdTos/ARU7SYqbMAGMjkjPPTewbZV6ajkY54yqXeXaQ8ZUJS+9PfC3m7V3jsYPoLSlvXdccwc9w9kdXq+5LoOe8dAHWK8iCNeQcwiyB0F0l1CeITl+1tzsTPD8xV1XMjkbbWl6KyeI0OvRKkDMW9+ZbNZgJJxG3hte8oRgZc3mNT3hDoIE8LylD+SUhafAhdssruS7CZV3mAl4mvLMct60zF2cb+l71fuSJk1isI6afGfm5bL2vxKpXUBIaAPHMebxzFpd22GVETe2p3f/UbLppae9j7B6tTtxRyMcKSwsUza6haAujx8h5PL+ouyk2LDqBO++y/IL55j7tx8XOG8vtBpPzXwxcIMVL/qa+iPVFKELppNG7c4JVuamy8qkAZGWseOtDqxtiKxOX2L3AowHnV6EDXvqHH/ddL1qxUoF0yv+c2Sc0HBKxRCfKku+ObarEOKL+4gWXWTG4M1x3UeHSfeXvqwgZe5c2gw4pvmncRrwwM2IRDDGBCllHPl/Y39XetjGr20PxKS9z3eBO4r/ShF3akC0chYnAxPtBtABbPjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(26005)(33656002)(4326008)(66476007)(64756008)(71200400001)(76116006)(8676002)(66946007)(110136005)(316002)(54906003)(2906002)(66556008)(5660300002)(52536014)(86362001)(8936002)(7696005)(66446008)(53546011)(83380400001)(6506007)(38070700005)(186003)(122000001)(38100700002)(55016003)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KiUTFceAguo/Rfa10Km98KfQIMN4ZxnDFsBSKM6fLvmxFlYcUXijk06kSR0N?=
 =?us-ascii?Q?garXCXbg0W0BisMNqloN9uUt58feey4/gp8NjRwSrHDWEPiJrZyeY1dh2vbq?=
 =?us-ascii?Q?l0olgaUhaVB2Q3usXbYGwVyWR2H5Llq6tN9+acBTcIpXhDhUEkMQ0Mdim8b+?=
 =?us-ascii?Q?e1D75TtPP/TIDMywttrzrAgA1rpMZditaEwW59MgP69sFdmIcVEGdYBYyfKb?=
 =?us-ascii?Q?CyKlppBVjUwsT2xOm65eXQY0arBduxyoEIIHLqdZMSQzIKnPKfrvM3cmfvzD?=
 =?us-ascii?Q?0FoCJJyJJ0h3gxG8L/VCejRW8TJ44CnvWa4z9cL1f5IuyLnucJToP/d4QUTb?=
 =?us-ascii?Q?WSynQ/0zOZ0HL+bdygbb8PQUyVCUSmerLAh5IXObQUqtPW8gzqv22roqpdkI?=
 =?us-ascii?Q?9lUXxwr8a2QSZpxpFpZKCHSCMM7EmyXYJM5JYR5YNII/i+wHg4V1foVodUq8?=
 =?us-ascii?Q?zsDvg8Gb5Varg9qvrMz3waACP0LXUkMNzXEjRrTbqs7R5UtsN8weNfw8Xl4N?=
 =?us-ascii?Q?MfAW4TZvJlFvfbNVCqgbeQgAxb9wkc0Czb9j6i5tTXSgqyw7v/Ukdz89mIjc?=
 =?us-ascii?Q?oCM5cCX8Vsw1cCYjUUxVP62k151g0PtjC9y6l1JLMmaAIx5KDOBruzyDlDF8?=
 =?us-ascii?Q?Ov8bYz6pSEzApiT2PwZ4lvPw0mibRETay/yCHnQOKOD2iyCEvCtM7HM9tUPG?=
 =?us-ascii?Q?4+B6p5jK6korn+qbkSHb7ehcTAe11BxVSsfd/cSLqPTWjoF3IhlWWHlbBeb5?=
 =?us-ascii?Q?3il1YL2oRQLVCbazK0TFGd1oBkoGUa7oMraUKZiZgIIWTYAdjMD4PC/yBe00?=
 =?us-ascii?Q?35Zh4C1gK9PlRO1KApLSY+gf2rh5mTFp7yyq28XTvLdNwz5XtBVRf1D7Ha2i?=
 =?us-ascii?Q?PIXZ/FUoouOyL1T91aSozILz0Axx3a63cs15F8SIEVKeHJvxPCoBAes/BwtO?=
 =?us-ascii?Q?PBNGe7kDXHWGcdsVdKHRjzPRL382GoMDmz77cViNygX3HNHaJRwuWA2xouLE?=
 =?us-ascii?Q?eg02b+Ka9g5wFs79kXFCz12VmZs+R0Wi/MzdOTF4VhPrd+NpbiuNAKLyzorv?=
 =?us-ascii?Q?AbMVkR3/70grqprUU/L7EEt4CAmmajQey1YeE4XOwxLkJq4vsQXwwCXfa4x5?=
 =?us-ascii?Q?l3oYbJ3toLtpLoa4Ja4yu9zE5Thn/+7ccrr3wBUiOfsvo43PF5Z7FyqJtPBT?=
 =?us-ascii?Q?wAJmRkV0G+D7YQBIxlcK2hn/j9CBVk2tn8XoSmwDrmEpDfs63iXlsMZuftIk?=
 =?us-ascii?Q?uDFjT/1MguMj0MiIvGUDUaQoFe/Vw/yHwNHLnZOjT0pWaLzsMW41SrixZSuN?=
 =?us-ascii?Q?lLYM6XocY57CY5w3wzBMCb4IiyaDo7q3ooVi6VsgvZ9GRiHnjjji5k6qHcrv?=
 =?us-ascii?Q?38wvQy3kOPYyCbFrOyelq3RaS0SwmmA9Gq56te+cZymLzTOVsymApB39UKHp?=
 =?us-ascii?Q?NFPUTavm1XbCfR6aFTtoJYRlxYS0DJhhh594/+O9GC4Cl9dwc+deMX3lVnQ7?=
 =?us-ascii?Q?9gZSTfp9JpNpOj81kEBxNRBsRph4kVj/7+SoGpeWI5FXZ0VLqblIQWV0W+8t?=
 =?us-ascii?Q?RWYWLX4/jykm6/zkhAwWdAb3zBg80qvv/xBSVasA2EA9pZV5n+mo0WHT0C4F?=
 =?us-ascii?Q?3QlJsNQImXHwbhnRssiVQTUP0hiOGbon5SVwfpKQOfEQFpcAqHRfHIq4kVNc?=
 =?us-ascii?Q?Du2mhDdtwvNYVzXgX7JrW+2rhHgXJ2yrV14aOsuU+HsFWD09?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7026ffe7-778b-4e42-fe13-08da45614be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 13:02:21.3451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOUDCHFx7EXjI39FJMCEWpi6pGSWcpzUtGlr5hza+Q7a6QPvoW6tn9TPveFya32hfpbxcexm8R6GBmsF/g0/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3907
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Shashank Sharma <Shashank.sharma@amd.com> for both the patches=
.=20

Regards
Shashank
-----Original Message-----
From: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>=20
Sent: Thursday, June 2, 2022 10:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; Somalapu=
ram, Amaranath <Amaranath.Somalapuram@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: adding device coredump support

Added device coredump information:
- Kernel version
- Module
- Time
- VRAM status
- Guilty process name and PID
- GPU register dumps
v1 -> v2: Variable name change
v1 -> v2: NULL check
v1 -> v2: Code alignment
v1 -> v2: Adding dummy amdgpu_devcoredump_free
v1 -> v2: memset reset_task_info to zero
v2 -> v3: add CONFIG_DEV_COREDUMP for variables
v2 -> v3: remove NULL check on amdgpu_devcoredump_read

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 64 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index c79d9992b113..1bfbaf65d414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,11 @@ struct amdgpu_device {
 	uint32_t                        *reset_dump_reg_list;
 	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
+#ifdef CONFIG_DEV_COREDUMP
+	struct amdgpu_task_info         reset_task_info;
+	bool                            reset_vram_lost;
+	struct timespec64               reset_time;
+#endif
=20
 	struct amdgpu_reset_domain	*reset_domain;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 89c6db03e84b..f1def74aaad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/devcoredump.h>
+#include <generated/utsrelease.h>
=20
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -4734,6 +4736,59 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_devi=
ce *adev)
 	return 0;
 }
=20
+#ifdef CONFIG_DEV_COREDUMP
+static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
+		size_t count, void *data, size_t datalen) {
+	struct drm_printer p;
+	struct amdgpu_device *adev =3D data;
+	struct drm_print_iterator iter;
+	int i;
+
+	iter.data =3D buffer;
+	iter.offset =3D 0;
+	iter.start =3D offset;
+	iter.remain =3D count;
+
+	p =3D drm_coredump_printer(&iter);
+
+	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
+	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset=
_time.tv_nsec);
+	if (adev->reset_task_info.pid)
+		drm_printf(&p, "process_name: %s PID: %d\n",
+			   adev->reset_task_info.process_name,
+			   adev->reset_task_info.pid);
+
+	if (adev->reset_vram_lost)
+		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+	if (adev->num_regs) {
+		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
+
+		for (i =3D 0; i < adev->num_regs; i++)
+			drm_printf(&p, "0x%08x: 0x%08x\n",
+				   adev->reset_dump_reg_list[i],
+				   adev->reset_dump_reg_value[i]);
+	}
+
+	return count - iter.remain;
+}
+
+static void amdgpu_devcoredump_free(void *data) { }
+
+static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)=20
+{
+	struct drm_device *dev =3D adev_to_drm(adev);
+
+	ktime_get_ts64(&adev->reset_time);
+	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+		      amdgpu_devcoredump_read, amdgpu_devcoredump_free); } #endif
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)  { @@ -4818,6 +4873,15 @@ =
int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
=20
 				vram_lost =3D amdgpu_device_check_vram_lost(tmp_adev);
+#ifdef CONFIG_DEV_COREDUMP
+				tmp_adev->reset_vram_lost =3D vram_lost;
+				memset(&tmp_adev->reset_task_info, 0,
+						sizeof(tmp_adev->reset_task_info));
+				if (reset_context->job && reset_context->job->vm)
+					tmp_adev->reset_task_info =3D
+						reset_context->job->vm->task_info;
+				amdgpu_reset_capture_coredumpm(tmp_adev);
+#endif
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
--
2.32.0

