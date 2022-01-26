Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702FDC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BF710E66B;
	Wed, 26 Jan 2022 15:07:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3085A10E66B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzFx2TnE034Hvgx3cJmJ4tMCazkfX9rIrGeN0eGc8umsubtki12ZSYmdkHkoz868FYJDXp2i4stkryBdeNSAdnm+xmbEBp9Q8v+78QlUV8dCaO9dVjFbgt8fOHLmoVhFhLcv60Wb1Mz12Bib1em9ieydOG2NVYRX+T+SDMCxko0KM1n9M+eLjpgmwjcK7uaQhsQxODGiyZ2xhz9Ygxd6+1Pa9LikF/XHrtFAn082LyWC6LBkPbRt5FcTX0OOfZsWi6X2nYmyGgtxVeDAD2lUmo1G0UMeAIRAW2wk0mmfp+sgxSJskjJXqFr5bVHWd4fB/CiIyYBTD8vhcPIfgf06UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo8CtzgNcRtn+LHdDq5QiSmA/M3ao9Tr1dj9Xf2hGMI=;
 b=Re/9C87VycOf4vX8Xv7/KPCgEF2xtgJM8iqmhrMlfZxYtda6SXV+HKiC7KfUvkFBkYYfQKe2WhzpS+QdKtNSKoufLc/yvTYhn1NB6lUanJIFPv6RrSLXsar2uPv+7T9dhNH0LY0243VkbhR+ufVcRFCrcyyJLjGIhD6eqEK4U+ORITTKXMwaT7in5rQC5ee2e3sHKR2XFfDbEn+jdPgNRzBEx3K/m7B3QiEBrNCl1ZOHaHXr1m0yuoupAAzt/hHJUIryRaln5Su3pG+vDCCkFe6He82+Ovj9pI3A0q+7v8T2KRVTcJAQkvu2ntDDFMM+nsckekJXA4mViF7w2l+l1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo8CtzgNcRtn+LHdDq5QiSmA/M3ao9Tr1dj9Xf2hGMI=;
 b=sUt/w17hDuNsOhBZL6oP1ZbwdigscredNbg5yoWZR18MZX5eqLCmiXDhLYCkVuhVuxRyautod6Y6aZ7ypz11xCiGI+KfRNiOXWDAFEG4jaj7pszZeZainw8j0S3+tNUN7UUUoc1GTSRPdBLm+6kxHLtxclJDam/bW2plkuz//w8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BYAPR12MB3175.namprd12.prod.outlook.com (2603:10b6:a03:13a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:07:28 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 15:07:28 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Topic: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Index: AQHYEmqNfmkF82KHjk6WjLq0eEjUOax1Z7aAgAAAF+A=
Date: Wed, 26 Jan 2022 15:07:28 +0000
Message-ID: <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
 <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T15:07:26Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-26T15:07:26Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Standard
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4b62c001-05dc-4c58-8226-0b058d2f4dfd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f690da-454a-4ce3-7a5b-08d9e0dd917e
x-ms-traffictypediagnostic: BYAPR12MB3175:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3175582654E1520CB942434EE2209@BYAPR12MB3175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2COfi2dMwAPQolWTxLU0LHxnevJuqGnjgcP+6BQyZmoGEWSFbdeqJXxZDTGzkLQ1FtQ6qQcEZWLumhOYjBUNy0W2ttiUymJ99Nzfr79BaBuLbWMdxm8aXgMckdbRUHUQvQ/0pygK6ovoaEle1lMfR03nN021F8UOVTZ+/CS3Ht0cJ7FCCrIZ+xw9HVgFa/kYFf5gDzAi2zNpvSCzXDo5CtNoSLL/vTEGTacEIIHe86GtAUfb6PuSPK9FBWJerT4ifsjYdMHmLDUyjuK8v48s5PONXACge3/sBbrkXteOno13V/GkycRJrX5SKWJOd7GAtFu1JSVgbZ9S27OIhGE1ZW7SnPnrh21cdMe+U83JCxExuULB8ly3FiroPbngzQPDidmplFSfBvaVE0TNlr5UigAWo1JzPKJY7rqg0OsPkMUbp3ojfqVgrDTR6afRv5EnHu536ZCVimi+41bV5Pf2BlwcNjvNN20w7EFilm5IjDzzC1UEkmym0tJ0GZhJCMthTg7j+opv7Bzu0vr4wQWSFfQC7Pn+4zX8H/gBRtYS+bnG3837gGVGcdKNT6U+SHVu4SN7EXyoDo15ST1tEKlDCPs4S7jTt3uyeRmvhIWeo0UNCC5Y6gar9givNL3w1OM06ye8P7RwzVEIJCE11zAG1zWx0RwcneS4eHczvPGjNNHApARi6Nwyaefhmbh/SSm8LKP62XwhB8ph5ygGgMedg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(508600001)(2906002)(55016003)(110136005)(38070700005)(38100700002)(7696005)(66946007)(76116006)(8936002)(8676002)(4326008)(64756008)(33656002)(316002)(66446008)(66476007)(66556008)(83380400001)(86362001)(186003)(6506007)(71200400001)(52536014)(9686003)(53546011)(5660300002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vjAtqVWVc1xZ+LrYb85X+DxmP4AZFnKVOFcWDdcD+3dYpx3q/EhnkoDnOEX7?=
 =?us-ascii?Q?i0iKs8jLwevdHbNuDoRGHepT5DATACBN6vPObpY6jIdCqC8NiV1mrTElkubP?=
 =?us-ascii?Q?IhYT+bZIeSYlFrKiF3TspAJUYRrS4uIBs3qp/JMD/fxcivaEjMegN7RcsUSP?=
 =?us-ascii?Q?/Jrhwulh3uKR9XMsxr/lm0q0z6/foD+kM+R+PPTrgy1dH3TEgqm+Rb44pDhX?=
 =?us-ascii?Q?Dwx78b+I1V2wBgz65QP4FyJJcRpsBF1gDxTW2OWWyPKlaJZiGzVkiUztbOcR?=
 =?us-ascii?Q?AhOMrAur48uZBiixx750lhDKy4uWxmY/qpqUbNfEayAQ8sKIKNfO53BK09eq?=
 =?us-ascii?Q?jtnILoGBY3YAvTr1K4YqFTbiM4cZZ+sUZfZkxvAoFlHQyDT0D3nx0EcRXBGc?=
 =?us-ascii?Q?oUy83+jEXpRQIeskA3xtAQvNTWy9+94pa6mVyNdBFohMD+ZJY7TYidgOqvBc?=
 =?us-ascii?Q?NYE14RlgplHTJ86edWvZdkdQYV8kD6APy11K3Ta/E2kiqcR3+0USjch1DyRM?=
 =?us-ascii?Q?XzOcCgd7Yz7CXjFaBBctbbePstRp7DRdJzcl549mIc3msE9MZlowPXA/wscC?=
 =?us-ascii?Q?4XN2+NwdJ9LHQTgE5VCCe9KOfBv1DZFpLP+4FAcTvRhb9Pdk3qRwvjAiaYwh?=
 =?us-ascii?Q?02uLpwy8iU3vzi90+3TZyxPRZJ4zlBhQHGVHJjmrsVQNKxbwrgs126MjUJq6?=
 =?us-ascii?Q?reLZ8DbwUPAlcMuURg3quVG+uvBUhXsmWS8RiXZYja1tGGob6TUAXOXxKBng?=
 =?us-ascii?Q?LTM9jP/U0Jh130SSyL4TkUteg2Lb9VXASDVK+2Ub1d1/gVoNpY8fWPPwOksi?=
 =?us-ascii?Q?/FBDlfZyR/v0LeR27OmrzFMiFIVyLSgqa+/66OSRQT6zrgHsfD7l5OGViulV?=
 =?us-ascii?Q?k2QTj0Tp92ZeCFmYU1S+qRt9/F/3ZH5Q5lHmE7kCBgw8045+kgOmnofrFj5o?=
 =?us-ascii?Q?nuJDnljw7J2AsyyV96625ZufpAzjTCYysNgc6STYIAKm3d7XhChjAiCXl/Dh?=
 =?us-ascii?Q?+Zeyecw8z27pQBvHVMssXARx7q4yQJojBBlezMYbom1Ybq1QVE/emuJ4eZUK?=
 =?us-ascii?Q?ll8vXXokJ06aAdwGobpBEH+sU4lrTwegWHz0K4KRiqy0Akd3KT+ksqcxVL15?=
 =?us-ascii?Q?P3Q3FiTf1LPF13VtVnETmg77Y7wTF4wPY8IEUozW6b9onbzfpBTT3UoyF86B?=
 =?us-ascii?Q?fBAwXtKqkvtoA6SgET6x74M7awYBsXAFVP1INESujw1CocCmaVGZBc8SuWd8?=
 =?us-ascii?Q?l40bTe9HJAeSGaeqy5vKjnI3J2vkkU5oofX/SVFlI1oS0L/1IlTxeryc8UPk?=
 =?us-ascii?Q?VDCVRThev4hry1uB9dTbAwj9m6IfOC7Vi9xq+3jq4hUhLLGuzDnuqC8qdeI4?=
 =?us-ascii?Q?yhSPxBKbwsIZW3V5W5HaIa2EgDLi4AaWwBcA7oVJ+KDv8s9XdzU0PpTYRHRp?=
 =?us-ascii?Q?ac7JspIYmYHEfQRgZI/aM/tO//Wgy84LlZlPELh9qoTngKHdIBsSPkdy1/7e?=
 =?us-ascii?Q?ZqmMaHN6sA2nCvM6IhTwXGUvl5f0VGvmwKpj6BsHFdAL4OB9GlJt7ox9hEXt?=
 =?us-ascii?Q?OlGSdQTQCE9NiaABT/q0EE9pcBrXOzMF5miTy5DEsb4nMioFzaBzpMlCSyjI?=
 =?us-ascii?Q?yN8oldWk6J3njcc7ArAF0P4qzKtQCnU0/7EU6Sqy92jyt+WliYIDWYFhPOTc?=
 =?us-ascii?Q?EOpmdU4ppquqNL/85tKTCkalfws=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5157001FFC7CC78C6AA12DF4E2209BL1PR12MB5157namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f690da-454a-4ce3-7a5b-08d9e0dd917e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 15:07:28.1922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epU+tqYUc1K7bHPEW3QNTOBUZklsM5VMoq5doklbiYu1fPGvZV/h+vWEO6jFOlddX9ainCxkn89reaRyguaPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5157001FFC7CC78C6AA12DF4E2209BL1PR12MB5157namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

That was intentional - shouldn't dGPU always be going through S3 path curre=
ntly?

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 26, 2022 09:06
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3


[Public]

Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.

if (pm_suspend_target_state !=3D PM_SUSPEND_ON)

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Wednesday, January 26, 2022 9:39:42 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is=
 set to s3

This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3bc76759c143..f184c88d3d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)=
;
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { re=
turn false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2531da6cbec3..df673062bc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
         }
 }

+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+       return !(adev->flags & AMD_IS_APU) ||
+               pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;
+#else
+       return false;
+#endif
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
--
2.25.1

--_000_BL1PR12MB5157001FFC7CC78C6AA12DF4E2209BL1PR12MB5157namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That was intentional &#8211; shouldn&#8217;t dGPU al=
ways be going through S3 path currently?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, January 26, 2022 09:06<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Limonciello, Mario &lt=
;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Returns true for dGPU always. Better to keep the whole check under som=
ething like this.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">if (pm_suspend_target_state !=3D PM_SUSPEND_ON)<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mario.=
limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 9:39:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v5 2/4] drm/amd: add support to check whether the sy=
stem is set to s3</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">This will be used to =
help make decisions on what to do in<br>
misconfigured systems.<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++<br>
&nbsp;2 files changed, 19 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3bc76759c143..f184c88d3d4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta<br>
&nbsp;int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *=
caps);<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_acpi_detect(void);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };<br>
&nbsp;static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *a=
dev) { return false; }<br>
&nbsp;static inline void amdgpu_acpi_detect(void) { }<br>
&nbsp;static inline bool amdgpu_acpi_is_power_shift_control_supported(void)=
 { return false; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2531da6cbec3..df673062bc03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * amdgpu_acpi_is_s3_active<br>
+ *<br>
+ * @adev: amdgpu_device_pointer<br>
+ *<br>
+ * returns true if supported, false if not.<br>
+ */<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)<br>
+{<br>
+#if IS_ENABLED(CONFIG_SUSPEND)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !(adev-&gt;flags &amp; AMD_IS_=
APU) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+#endif<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * amdgpu_acpi_is_s0ix_active<br>
&nbsp; *<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5157001FFC7CC78C6AA12DF4E2209BL1PR12MB5157namp_--
