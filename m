Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B2ECCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D06110EB1F;
	Thu, 26 Sep 2024 09:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uui66r+x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453F610EB1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q48CmLusRqT/ylTuiwbxurtjom6vlpcjpa48u15Fl65EnNraJ1p36own178D5K0d2fhcSjp0xH9O3TgxlAJEUlxQPimc816mVQUdyIdNDqDy5jqJsH0EBuck1XlczXmIml1HuWdHkqDE0NuzXmmG3gEGCkaTzg20je5AMGLBlhlkz3HD8MXAD+w7VW7ae2dvdoOA6sDT1BhgmmkMDvOzvTzydjkX7Jj/zAWXFAS6cop2VI1q9+uuWS898DM/8aeKbleVhEqx8QZWNBV4SKhryN+N1a5HfcoCM1gNreduBdPuSxWa8fJY6Jq6jEQEjABYqa0X8xyybCRyjzBw6EJAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF9ZI6IY707PWtdpJb2jFXpwpjzz58V7FjdSQNxZQvA=;
 b=P43WMG7hBaXmhVh254ExcQFkCadRzoqwdXYcRgaXmRbrXRWQYSLF+0Drf/zd+NP3axlVfSmaOjLF3eKJyfKM3ec/N7mf//giA5PJAm6OY+hlGaEVH1W5BdANNgX7CCcl4VtY07WdRYA+fPDZSs5QKektUDM/fwrzzw42aiaw8eDPLkDZe7qG16UjBHaL4t/IAVF9YnBIOgLdtyEFxibO3BvLen93hMY5kV9O6xQLs5yi4lFLcM1BD4htSsCOtV5asfA1+eSM13oTulN7hrRYCMGkRlTyGEbEYHH08R4tJG1YO2Hr34D9wZjMVajRxkxKFPIRfKr/s/MHGdfDUylrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF9ZI6IY707PWtdpJb2jFXpwpjzz58V7FjdSQNxZQvA=;
 b=Uui66r+x7EQ6B+TCj5JmEL+ReCe01snRL2z6FvlrhIAHVjvq1WKrZ0EsLBL3JQ3hZUEY7jCZtjcMU3hcshTE0J/sCvD/LbgORFe6SE8E1WXnxsrvKg8JsdoqWx/nquFlucvJLu1XobK3dEGXH2v8b4nlQMhQt0VRo7YEAVeijw4=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:07:06 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 09:07:06 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>
Subject: RE: [PATCH 5/7] drm/amdgpu: Place NPS mode request on unload
Thread-Topic: [PATCH 5/7] drm/amdgpu: Place NPS mode request on unload
Thread-Index: AQHbDkaqaMrIpohwe0KfTlX9B6lTSLJpylJg
Date: Thu, 26 Sep 2024 09:07:06 +0000
Message-ID: <CH2PR12MB415264B934C621DEDD0DA8E2FE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-6-lijo.lazar@amd.com>
In-Reply-To: <20240924055652.2678433-6-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8a8644d6-a43a-45ca-a7c7-2d1df6c272a6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T09:06:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 09bf92a1-94fb-476c-0f1f-08dcde0a9851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yrcyCaVcG9oh47HusSHhOw4vHs9y9xFjATLftFYzyqfKbWEs4j5MAhp1RKeN?=
 =?us-ascii?Q?VJi+B2LByvDdU/gmJgakjJPFPfKMOMSrNmnMqkCsvnTO/MZmFxiNK5/MOyXF?=
 =?us-ascii?Q?gsGJCY0XICZQqgxriIJ63p0lLDquK0+nAw4vcgAb4OM3YditcIs03S90jEUM?=
 =?us-ascii?Q?NDdaSflCC3+xCZxdwNxymYC7hVCYEnL+AgUhimgY63A2jvD3RTvdEGdCtsg2?=
 =?us-ascii?Q?wGrZfuUJdpyJkSomaCB6H0mCtWcE7FWOXX3OSJsgBljaMS5/lA19c4cIR7Ay?=
 =?us-ascii?Q?lbmVdHsGcm8FjfgYGwWGLe20i8xadIxwMEmno/Le45Dbsbzm4BF2nvtduB4J?=
 =?us-ascii?Q?ENB6DWQF58pF+A+cB65ifiN4STlrtYb6w5Kv5aBb3h2HTf+lt6Hlv3iFnctr?=
 =?us-ascii?Q?heMzbEBrqg+HaIWWlPochfv+geKUd1nQ57BVls8jQzwOrh1qbOfbtN6mLQ5G?=
 =?us-ascii?Q?6eaIklapnkXQr9HsSie5DfupOATM4dUCidhL9GTBnCdK2/1Vmd0zezXQ/9YB?=
 =?us-ascii?Q?wZsOd4COmim2lgbvhSykTFeDUiPjHq5JLR/ceHn9jY7C8bb6OqxkoPj369Dn?=
 =?us-ascii?Q?BGVcv6+KpHuu89dREIgj0EXrvckyZ2jBmmmtc2XwoCKhWmvSZknPfTBs/njo?=
 =?us-ascii?Q?16FNKXCUu2vXMDle/41TBSgVRSNs91W3R52JZjVScugP4wK4goDiR8TMh8oT?=
 =?us-ascii?Q?KLxV3JmMJdESPW+q7tEhPIZORVUCrBlXSQ0kbK6xm74Skvci0K4Ermzb2ZmE?=
 =?us-ascii?Q?D1Bob6ItVbGEVqsBzdAwzrwEbAAgR0KqcCXor1ANxPBoLuNijhIZab/77ol0?=
 =?us-ascii?Q?zK5Me3y1utEhK8DmkFXm5BhhHO6LonPRGPypYYbUiP3QiZHK1Gcsrix0pqiq?=
 =?us-ascii?Q?unE3E8U4r11daxqHB/VT49WzZTc+ZEmqqiWY+ABcqT7+DftJbB5i/rW/G2Bz?=
 =?us-ascii?Q?dxtclb3s6VD0XenQ7fNXTDRFFshlTbXoVY5BdanLunjITEaEJFvColNo1Jjx?=
 =?us-ascii?Q?H/DRFGrFc4jxCcD4lvHU7z0cpgns8YTkV4mMetpE3XvN6rt7it1XZ8cFORzP?=
 =?us-ascii?Q?GBG6NI7NyRb7z9q30wiu3qayAhKdl2ecd2wWKzkNG2yL7w3FeqSzltviRdwo?=
 =?us-ascii?Q?qdT8wh/kzaTyyYD6FA8q77fbfdRr6DDM/fA5xtpu8m85vPDuDCAu9y8GDnNE?=
 =?us-ascii?Q?MAFSlqYS5Aa9vDdQ5qRNSlx/0Q0rFRNDqOwwNZLqwSm2nj57L5sb9c1M9gWO?=
 =?us-ascii?Q?WDcZSPm5grw21UW2zTr8tRbRclML0jfQqm9cWL/TEZXbCdJGVVxyg+pA8WRz?=
 =?us-ascii?Q?vTlenBsf60a3Dw+osP3FTHmzp2f2yTI/RnEKEhfRZtLL9V4mRW0cgxS4kgOD?=
 =?us-ascii?Q?nZWWgLiiXqQPJe2bKXW517tN4FjWXZgo9OhqJ6F96A2/cTInQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0OemPwOGLAyJ4FaCagG2DsCQXgtizKnHpfTCtObAMHYaivkhVdSDu1Esa2w8?=
 =?us-ascii?Q?dfxrJTXnPbjaVi+bLCGUCbP000JmMsezHWKS+wPxjs8NBdxBuFaDXPK2DtP1?=
 =?us-ascii?Q?Haard4sTyfoZzPU81uK/mdIB4R6jMj15Whppvayf+qodv9lUVVRY72sTR+sO?=
 =?us-ascii?Q?ThgcbPei6UxZ4zmS4WQcQOWx4HrhCX9A49zRwGv+EyAJQ3CU/kcebL+297QT?=
 =?us-ascii?Q?2OLed3xUlab8rf+EDP3fA4ZwmrTfByGc2nEK0qx230IitI2Y86gTa+aNvgQp?=
 =?us-ascii?Q?IxeLMWOVBguGuxXAe2ajLsf2S+1NCeWoo0qR8iZPYBItGb3pBXjhUvqp2I+n?=
 =?us-ascii?Q?nHOH75HMect0oZ1RT5YFnqZRF37L/radkwqq33hs0T6qAnVT4ITgjRhMVBAd?=
 =?us-ascii?Q?ICdW2/AjOpcL4xksoNTWxG1tR44hrvfLO9hsWswTCkfe/sBBzjslftxZnqhx?=
 =?us-ascii?Q?ufEC0DtUZ0FfWnp8hefINkTwlYmbDxSKY1aFLHPzDS95O2jkSFLY2bzyei4r?=
 =?us-ascii?Q?FEiARIgJFXmb6yHaxwKSrokhZ6z4FYRrc0e+n4COBPWR84cDO2kl2x/ZPb1J?=
 =?us-ascii?Q?qyo/SyrJyF8EqkGX5yHZwB+7rEvNbxYcd7wUc/A1jLySJEvpHLj87e5RdPUZ?=
 =?us-ascii?Q?6NZiPuO5qXqI3eNT8IDfg1CmGbNcKypFhUlf/Y9Mbl0XSdD29Bem35tAkU3G?=
 =?us-ascii?Q?r9AHwwwq3u4uUbpAPyurUI02EIaQkSTfI+UR7T15/9AmZYqeBahnlRuwdhrS?=
 =?us-ascii?Q?Evhm1HZ2YDSrUZblqZzDYqGmD6+C1bj11quDD7yEz5mKyd5rC+moDzSPFCU/?=
 =?us-ascii?Q?fXIdvQCii8qbcYkkDHJufCMeBP2xdmCjD7pfYsU1exgdU/FQ/fJqvWA/t7U1?=
 =?us-ascii?Q?/w3zC71w2oImU6mtqq/10m6gKMVyMIfVZ+F1ZaZyLD22SmU926Cha4l/fwOe?=
 =?us-ascii?Q?9Hhyr6fBwuVUNhsVV4hcoar/UHqxSRXESxf7B26RvrFs3rU4IyNtPjeSkAFl?=
 =?us-ascii?Q?riqKNEsEoZowsQVMdM2WroRdct+c3rHznsgAbNFuIjhPwvNwVk2ynP8Aqw8z?=
 =?us-ascii?Q?oD1yodRBaqOewyGla3Dd4/w9vIx7+T7QzweIbsrLzgpWCN+jPw/eYHkp8bBX?=
 =?us-ascii?Q?0s22rpVFVQSMZgIo8k0Du9fQ62WBLITvZ+g/QYU4G2EcXKnYP+tO3xYnIjtE?=
 =?us-ascii?Q?BuKhtp7F2FFwXf73oAGMNJ8fO0TD16d+Dx3dho30nsssQp8r7xIObjHQiQga?=
 =?us-ascii?Q?RRJfCSQEoQgIGpmPTa03/eeuJv9cUlE3XyW6LHOe6vFoVk3VXsEay02v2HgC?=
 =?us-ascii?Q?t3xM6qmazkGkkBqd6U9oJovH9ahMVShF3QfFMJwceAfV4vSod5EH/NSjaXqC?=
 =?us-ascii?Q?FvM13bbPitE5ELOccYQl/yTq7qiWDPn+bzhCXogstlZI2tBhEjCHeTkogqKd?=
 =?us-ascii?Q?yY7At9timyNuKsFRoxxtpenH5mRmbIfCPnRkuNKgSlpeudLXIdPS3Sqv+mrY?=
 =?us-ascii?Q?/kNkjKJiBjqd+Z7IHlrLJw60r+8+6UBbS5NkvWyKFjPZYVEBGZZYQweQ3mKn?=
 =?us-ascii?Q?QSjCvKOftoyJnFxS/mk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bf92a1-94fb-476c-0f1f-08dcde0a9851
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:07:06.5837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YM4Ixgjj7NV0urp2bSNdGRDlA2q2RVx2NXPsYhsnRWKYf4TUIK42X+sUh9PnFtWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 24, 2024 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Ra=
jneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.c=
om>
Subject: [PATCH 5/7] drm/amdgpu: Place NPS mode request on unload

If a user has requested NPS mode switch, place the request through PSP duri=
ng unload of the driver. For devices which are part of a hive, all requests=
 are placed together. If one of them fails, revert back to the current NPS =
mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  1 +  drivers/gpu/drm/amd/amdgp=
u/amdgpu_gmc.c  | 47 ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/a=
mdgpu_gmc.h  |  2 +  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 38 ++++++++=
+++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  4 ++
 5 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 95331294509c..d16cdcdb2114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2428,6 +2428,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
        struct amdgpu_device *adev =3D drm_to_adev(dev);

        amdgpu_xcp_dev_unplug(adev);
+       amdgpu_gmc_prepare_nps_mode_change(adev);
        drm_dev_unplug(dev);

        if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) { diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 24a1f931d9ed..21f1e65c9dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1345,3 +1345,50 @@ int amdgpu_gmc_request_memory_partition(struct amdgp=
u_device *adev,

        return psp_memory_partition(&adev->psp, nps_mode);  }
+
+static inline bool amdgpu_gmc_need_nps_switch_req(struct amdgpu_device *ad=
ev,
+                                                 int req_nps_mode,
+                                                 int cur_nps_mode)
+{
+       return (((BIT(req_nps_mode) & adev->gmc.supported_nps_modes) =3D=3D
+                       BIT(req_nps_mode)) &&
+               req_nps_mode !=3D cur_nps_mode);
+}
+
+void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev) {
+       int req_nps_mode, cur_nps_mode, r;
+       struct amdgpu_hive_info *hive;
+
+       if (amdgpu_sriov_vf(adev) || !adev->gmc.supported_nps_modes ||
+           !adev->gmc.gmc_funcs->request_mem_partition_mode)
+               return;
+
+       cur_nps_mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev=
);
+       hive =3D amdgpu_get_xgmi_hive(adev);
+       if (hive) {
+               req_nps_mode =3D atomic_read(&hive->requested_nps_mode);
+               if (!amdgpu_gmc_need_nps_switch_req(adev, req_nps_mode,
+                                                   cur_nps_mode)) {
+                       amdgpu_put_xgmi_hive(hive);
+                       return;
+               }
+               r =3D amdgpu_xgmi_request_nps_change(adev, hive, req_nps_mo=
de);
+               amdgpu_put_xgmi_hive(hive);
+               goto out;
+       }
+
+       req_nps_mode =3D adev->gmc.requested_nps_mode;
+       if (!amdgpu_gmc_need_nps_switch_req(adev, req_nps_mode, cur_nps_mod=
e))
+               return;
+
+       /* even if this fails, we should let driver unload w/o blocking */
+       r =3D adev->gmc.gmc_funcs->request_mem_partition_mode(adev,
+req_nps_mode);
+out:
+       if (r)
+               dev_err(adev->dev, "NPS mode change request failed\n");
+       else
+               dev_info(
+                       adev->dev,
+                       "NPS mode change request done, reload driver to com=
plete the
+change\n"); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 1a50639a003a..b13d6adb5efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -467,4 +467,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *=
adev,

 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
                                        int nps_mode);
+void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 5d721ccb9dfd..db2c1b11b813 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1564,3 +1564,41 @@ int amdgpu_xgmi_reset_on_init(struct amdgpu_device *=
adev)

        return 0;
 }
+
+int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
+                                  struct amdgpu_hive_info *hive,
+                                  int req_nps_mode)
+{
+       struct amdgpu_device *tmp_adev;
+       int cur_nps_mode, r;
+
+       /* This is expected to be called only during unload of driver. The
+        * request needs to be placed only once for all devices in the hive=
. If
+        * one of them fail, revert the request for previous successful dev=
ices.
+        * After placing the request, make hive mode as UNKNOWN so that oth=
er
+        * devices don't request anymore.
+        */
+       mutex_lock(&hive->hive_lock);
+       list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+               r =3D adev->gmc.gmc_funcs->request_mem_partition_mode(
+                       tmp_adev, req_nps_mode);
+               if (r)
+                       goto err;
+       }
+       /* Set to UNKNOWN so that other devices don't request anymore */
+       atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE=
);
+
+       mutex_unlock(&hive->hive_lock);
+
+       return 0;
+err:
+       /* Request back current mode if one of the requests failed */
+       cur_nps_mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_=
adev);
+       list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
+                                            gmc.xgmi.head)
+               adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
+                                                               cur_nps_mod=
e);
+       mutex_lock(&hive->hive_lock);
+
+       return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index 67abadb4f298..41d5f97fc77a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -79,4 +79,8 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_de=
vice *adev,  int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);  int =
amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);

+int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
+                                  struct amdgpu_hive_info *hive,
+                                  int req_nps_mode);
+
 #endif
--
2.25.1

