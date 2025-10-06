Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC23CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 05:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6113B10E165;
	Mon,  6 Oct 2025 05:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lat6Fw/I";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0035310E165
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 05:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDj+tz12xPh8SugUEGZ7fJZieW5t5MYFzeB7Q38HONQBBOdLvUG0ansjHCD9YQ8u6z89NteqVmpz9Q9kO27Dla2oEZ0gNngaLQKm5R8gnxKtqS+V1FeRM/MgBv0Car7JE0K9/HraB6WgmUaOm3jQv6FYrOa+DzweysIXti1bugstdawbnajwID9Xbpe4czApen1birM8ak7LAu5ex1OxAQ2trsYddg4cd8ycJmajI8wFyFroFoRc7WFpl0r7/IvyEJsYu6ptg1/pdGR0h3huFU7Hh3VdF7/ZRxQV/zmK1Hkiysdahg9eetp5gQQxHYWpAIhOWV867/UbF7A0eVt6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AcZS1d73RYGkPSh1NYbW9wauPGZPqB98DYAOb0hEIw=;
 b=Hg1JTNCJ20jXz70EpWMiU5ty2jq9tsWcKNIebXDkBB67jJyfXmD9iu/iAhwm6a87xY++QrTb5afTe4YHpttCoKT+7lLvUhF1BMUTcRwI74Ag0EIfhykkMmf+0UekfMoU7a0Mqqfwss8JlgIgmk8/Teyyn0Goawb0TBticXGSJmukbE3nfqayMwsEMyfzyzV4fUpSPH8GdEtK3Br6DtVfnI0B0TBTrajZjNj6paBVxCMo0v21snrmPdj627jn/Vtlq0EdgtoBne3Ocxj/moVItMDXDef1ET+miZnJEeZqwnmXSHDa3zBD5SJiWjz+yGZ30hSMWlFJOkpwKo/rT+jmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AcZS1d73RYGkPSh1NYbW9wauPGZPqB98DYAOb0hEIw=;
 b=Lat6Fw/IXY5P5bUaIY0iikSOEGx/yrgZg4/RElc5lZoLGaHQCQ3PCRgM+iNXaCNdu/Je6NePb68fvshEaYLtp79doZdwC4bHkasb6zMzH3vpTgW1R7ffwhc7Y6tZxGAVVu6H4jFJyHjAsV0MUo6q+TZLOkq0a6FeNtb8Ech+ns0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Mon, 6 Oct
 2025 05:53:12 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 05:53:12 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Report individual reset error
Thread-Topic: [PATCH] drm/amdgpu: Report individual reset error
Thread-Index: AQHcNoDWk9Lw+0qmTkSY05SeC61jybS0nfiw
Date: Mon, 6 Oct 2025 05:53:11 +0000
Message-ID: <DS7PR12MB60717F239D0F273FD590E50B8EE3A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251006051925.3354101-1-lijo.lazar@amd.com>
In-Reply-To: <20251006051925.3354101-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-06T05:53:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB6935:EE_
x-ms-office365-filtering-correlation-id: 55281eb3-debb-4248-930b-08de049ca270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KsJHdUmSyKPnaQCDWswmuwIfrvll8VR9PwQz87ySQU4n+40g1I3W1CwmeLKz?=
 =?us-ascii?Q?36RyNzvtWkyqP/bJoyWb3+z+Tcn+FR5sB2QMJ3W68QUJbtRmh+myXfO+qssb?=
 =?us-ascii?Q?kau2cCmqZOrJ8jJvm0+iTBhUHzbb4V2OU0kAbXB6ObZfyoPGBdoqQ0VP7zdk?=
 =?us-ascii?Q?tmnhnZbXlD2yVpC4YNRP4jT/LpZ/UgKJ06Mp4jypO62gJQTfl9Y+FjnA1u8P?=
 =?us-ascii?Q?rknGLyXhGZLsw/1AnLM9K/fTSYSwz6XBdq/fwY/sBVyLMX3UY76UrfNchzKk?=
 =?us-ascii?Q?aazQOT1pCycRFsNW78OAqCOPyJ8sua+oKR+c+XTrZXEM0GsffIniGDlk0Y2K?=
 =?us-ascii?Q?VE5f1iU446BFyjb5TYN1PwR1RklZYLwLJBMxcglcde3sn63YobXVEh83sx0E?=
 =?us-ascii?Q?GE56EDX03wX5TQsQCivPx/GLqR7YuOHHLdQ9daMnUBmv/XMyR/irPDNXJdV2?=
 =?us-ascii?Q?IgPWOBk7Fr1WzD5PwEkcfHq6NjFLLUMYYmDyo9J8nJq5tR6CjUhFbvO/0Bqu?=
 =?us-ascii?Q?HBnoZ8tSAkqXeepRr9L86u24viuoHYStmCLcB9vQPrQK9uPdus8ORX9ezXLp?=
 =?us-ascii?Q?Cue9NMj3G+pEYGWn/n/qsGS364J2aqYgONygEpTHRkDJkT5tmKKMqfKn0jbq?=
 =?us-ascii?Q?ajdmIuf6Pkrdq4oSXGENFeX6w5CrjpaBYULvU+DKap5FpFbxEWF8YmYZkNAl?=
 =?us-ascii?Q?485JfuZLzlM03Y6p3uuGvd3Lr0S7suFBBY3nHa7XoMBPvko/CF/9am+09KR9?=
 =?us-ascii?Q?nzAo8uhEe2+tXzid3ZptGCkUDakJnRyFcF3J/4oE8tyAd3yf6OAOVnvYrK6i?=
 =?us-ascii?Q?Q5Eeds2MzMWyAsaqJdVJFKoN/iNnH+SOUwzlLXGz8ogjzPbSky6OA/897FR0?=
 =?us-ascii?Q?zEAQUXIAP8g6ZjVSw86JJMMNgXzDQh9LDY5kl8Yto8lgf5xtb/Sy1DgGOfTz?=
 =?us-ascii?Q?BzEMqfVfYTRh02KOfvNODMycWASVdTTCzuCC/Djv4sfh97rOEgfk2VYqUDw2?=
 =?us-ascii?Q?jpvaG2Y7W8hN+IgX0Cz7Wx1gNQBV+H528xxbjBuv5aTWaNdd4+O4/NZ78wIp?=
 =?us-ascii?Q?48KPva14FsoGItPtLhBhxPS//anF/fepIFaE3iiPLOBrb1lhaoDWlso0tY8y?=
 =?us-ascii?Q?H6UelnixpF4l9fH5jRy1m9r9zvcE4nExPwblqnAD6FFFKzNkO6kG3Tccm/84?=
 =?us-ascii?Q?slsikZe+sfSdIilMa7LuW1K9bxo1AVlI5EYJ402q4xZXuz+hldiaKKSaiUnk?=
 =?us-ascii?Q?GuUfAWXhCnfTn8YatoqVFz1sYonJlU8RwA0dtabbKP0k1mKVFEPXxbQkkmud?=
 =?us-ascii?Q?MxZvH8Hdl9P1nrkBYJaGiapYGi9lpZg2V/ablXpsjnZlhukiQj/X0xYb4P7S?=
 =?us-ascii?Q?NAnlBeckxyFxcd7nwOBnKZLEQRw8ZIO3NcSlJVuPcIAlQmEYnYCHkuVDdS2e?=
 =?us-ascii?Q?oFuREcO1KExtyAZPolb0bmFqydOM+sKoKeSO2goVM0Qd2JxM0WJj4Mc8V30G?=
 =?us-ascii?Q?Z8SYys9S9Sn+OQ/5HKBsMXKiVKpywR+icCdM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1H9YfvbsfvlOcJkUL4E6mQkXST/RCcaxgBvX8IHV3+lw8NxAYfxl0ZvxdM7U?=
 =?us-ascii?Q?MyEomSRtnGuTE4SVWpJwXwKHlsDRRw8AP3j24heLi8oWv1cWQ4fVzG5x6u+a?=
 =?us-ascii?Q?1IKhrUNutVyzgtgkh6E/H7D/0HBBQD2yGLcehowu92Mm2iTr9VLjFArTwxCp?=
 =?us-ascii?Q?NuyMkxfVl+Clyrr1NGS4JwmLmX7yOkvGMjRav5lgLhABa7+HXEw4vuGCTBOS?=
 =?us-ascii?Q?jwMsFVg0miAhP9rpRkW6ytnvH8PISbiLfGyOrcCTQ8brcrAECCOr5iwUqIwP?=
 =?us-ascii?Q?shAtBkHAp982c4lUtPuxni/fTJ4y42gZKHUfHFAwWDr3gNcHc78ID11ANhxP?=
 =?us-ascii?Q?j043qsRMfxkWvLzV3ajxIubnpeo6PSKaJVtaXmjUxHGqGT0Cd+bmeHLp9Rlt?=
 =?us-ascii?Q?4tS/y0N1Gp6NwUlrEn0zU2ZsluJBQrPlANZghHfu7Kos9r2EWoQIy/Z8Nu8e?=
 =?us-ascii?Q?u/KN9c4NhqyY8HRAsClEZRGFLLJZQY4PC+g89wQiPI4OBM8EzEPmgb9zZrml?=
 =?us-ascii?Q?vvUvKIwh//uR/HxWZw5fViPe+WCtf/hS+3zRdimkhlOjxsT3wD8xb4H/EGl1?=
 =?us-ascii?Q?MNOAVCb3JMXcYe44IygdF+QoUfdbRonCgF9GraEH1H1aMvM1lzAKz+13HeTh?=
 =?us-ascii?Q?EzrOPCXBDJY8LFZjb2Igfn9lpLiV8UVyJRTwRYS+hqlSEU8Z/r8Cev4gCSV0?=
 =?us-ascii?Q?bOtbljmDunahY76EFyybx9pomzfomfY/05E5nyzl5HNAlIDe8iyqjPzthMA3?=
 =?us-ascii?Q?nocbjrMiCnV4m9ecnQG1dANrnIBHl9wze6NmWNNtfNbANYTDk3GEi5Rs4fIB?=
 =?us-ascii?Q?Z4auulNeCHWaLIkY7xMIshL/cWwr7lSEHwg4CIrGTpkN2MJjJZ/wFOnw4w7L?=
 =?us-ascii?Q?+vLSBb3QsjboGOZlx70XSI2mr4OOpLjX8QKe0gcxdkHdd5/0jVhCxF70bkTo?=
 =?us-ascii?Q?IhNuzY9lqwPvLFl1G9avDHUpBZUOBIJEhq0ZQLhni8Zwy0QV7kfyeXqpEzaq?=
 =?us-ascii?Q?Uz0zYiTMTHNeuewiiIojprVrUxzKHh51VF/+vsv0f6njyJEXGcFeHj5E5wtO?=
 =?us-ascii?Q?9i2RhXhGg18bt0TugHJ4a1cQb3anhOTkhqUTQpDlfCt0zoUofWkWNH9GMUOS?=
 =?us-ascii?Q?f3Clzya3mR5Za26YFIXXPZfavHFA+tCKWyBGsJ3rM74687Xfj1xiXvP3GZao?=
 =?us-ascii?Q?f/NHLsJ5H6NbAJN0pT9Of18BH8dLIUX8t8uQfa8g2sL6q5wDhq7Ooc6B2UKI?=
 =?us-ascii?Q?6CFu1NcYj/HPZm1T0yCQMo2X6Rqg4XUjSWE27KkhlD2bxSxqEhOVUwxMf/OU?=
 =?us-ascii?Q?O9hSP0IX1i0rFfJbFyZdyObMbtYyk4NBPSTFIYS02lUyzQiNsIO7kGDU/Twk?=
 =?us-ascii?Q?YaSr3k6GRrB791wTEopscVUjgYm9Sw2isRpnGJZI62pnmRT7N3YZ+9bOkcAG?=
 =?us-ascii?Q?F97b1ZehJ61vclDRJNp2WuErPU1iQNOMkNly7hG6fbGViBmzIjzabIQpPhTI?=
 =?us-ascii?Q?pe5GZV+gnsS3g6QgSIN1gDLHpXOmsirbyyiOcfN3ZnX7kq5KnitCvfmdQwMa?=
 =?us-ascii?Q?JDUVog8r6diU5eCkQPI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55281eb3-debb-4248-930b-08de049ca270
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 05:53:11.9612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjRTWQDlY4YV5Nus2btGdDysi3gr4W6+Q2o7W7SWAtqWdpLy/KY4UrX3Qdsi7ZFK1BFQ+K9PZVZZBW+o6sBvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, October 6, 2025 10:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Report individual reset error

If reinitialization of one of the GPUs fails after reset, it logs failure o=
n all subsequent GPUs eventhough they have resumed successfully.

A sample log where only device at 0000:95:00.0 had a failure -

        amdgpu 0000:15:00.0: amdgpu: GPU reset(19) succeeded!
        amdgpu 0000:65:00.0: amdgpu: GPU reset(19) succeeded!
        amdgpu 0000:75:00.0: amdgpu: GPU reset(19) succeeded!
        amdgpu 0000:85:00.0: amdgpu: GPU reset(19) succeeded!
        amdgpu 0000:95:00.0: amdgpu: GPU reset(19) failed
        amdgpu 0000:e5:00.0: amdgpu: GPU reset(19) failed
        amdgpu 0000:f5:00.0: amdgpu: GPU reset(19) failed
        amdgpu 0000:05:00.0: amdgpu: GPU reset(19) failed
        amdgpu 0000:15:00.0: amdgpu: GPU reset end with ret =3D -5

To avoid confusion, report the error for each device separately and return =
the first error as the overall result.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 929936c8d87c..7a899fb4de29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6389,23 +6389,28 @@ static int amdgpu_device_sched_resume(struct list_h=
ead *device_list,
                if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && =
!job_signaled)
                        drm_helper_resume_force_mode(adev_to_drm(tmp_adev))=
;

-               if (tmp_adev->asic_reset_res)
-                       r =3D tmp_adev->asic_reset_res;
-
-               tmp_adev->asic_reset_res =3D 0;
-
-               if (r) {
+               if (tmp_adev->asic_reset_res) {
                        /* bad news, how to tell it to userspace ?
                         * for ras error, we should report GPU bad status i=
nstead of
                         * reset failure
                         */
                        if (reset_context->src !=3D AMDGPU_RESET_SRC_RAS ||
                            !amdgpu_ras_eeprom_check_err_threshold(tmp_adev=
))
-                               dev_info(tmp_adev->dev, "GPU reset(%d) fail=
ed\n",
-                                       atomic_read(&tmp_adev->gpu_reset_co=
unter));
-                       amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_R=
ESET_FAIL, 0, r);
+                               dev_info(
+                                       tmp_adev->dev,
+                                       "GPU reset(%d) failed with error %d=
 \n",
+                                       atomic_read(
+                                               &tmp_adev->gpu_reset_counte=
r),
+                                       tmp_adev->asic_reset_res);
+                       amdgpu_vf_error_put(tmp_adev,
+                                           AMDGIM_ERROR_VF_GPU_RESET_FAIL,=
 0,
+                                           tmp_adev->asic_reset_res);
+                       if (!r)
+                               r =3D tmp_adev->asic_reset_res;
+                       tmp_adev->asic_reset_res =3D 0;
                } else {
-                       dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n=
", atomic_read(&tmp_adev->gpu_reset_counter));
+                       dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n=
",
+                                atomic_read(&tmp_adev->gpu_reset_counter))=
;
                        if (amdgpu_acpi_smart_shift_update(tmp_adev,
                                                           AMDGPU_SS_DEV_D0=
))
                                dev_warn(tmp_adev->dev,
--
2.49.0

