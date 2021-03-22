Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66432C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136916196F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136916196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF756E3D2;
	Mon, 22 Mar 2021 07:26:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286796E3D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A01Z90HFMCGLPP5wJlvxg28HaBiNi3JJfH7PUdRzdjyqOqN3Wv76zUUeyp/9tSxACZv9sROkhqOM9CX4Tww2kpJo+oILVIVevBgbNfybWdP7sb3sSoL1ybgm7/gbxxx3Bain+d3TkwGDWT5E+2LBytVaDWzQ73Kv4vsOmI/hG5IJL83g2PEMBqVhq9FOxs0bctKic4M3743bBmSfvcIqoGYdQAWI8wEMkgXq4DRgTSwNNKhSAplKE+AOZbedJchCoEEok+g4gd+bkYUaOeUNI+y0z6OUrABjAr+MI0ECM/+hdBpPo1bbEICzqgq7J8LgSSa+mD7kqYvsFMgTQGWJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kc9BmDytscUXZduAdFTphvYJGuoiIHydNXKPeeb1Co=;
 b=jmq899KCgxbX+XED2OKTDULKmz2GFznxLomDdiMpixH9GKl3yEZZKa20KJhbsmdZtGb1ovi6yYvoxvyxYvPiE8v1w4AYMetDfAy+61lcqoH3dC6GXorvSPY298HF9pQvsrLFDHEN5Fy/ICek+mTdclCzBVEFQ6aU06jnPwPX7nskAA82lVALWpTfNn91kSwtiZpZ/50mx2gWsenusC9fTrw+tW99hjp7VU0nEC+p5ICpM90e4rPuz47T3j7rkCN14i6p12f9R6qyD6ZEEHfJUTs+ri4aqsxWMQMX1S99x98SBp8HeQx5xDS1LtufzF4HGboxwPpnxh4M6SJfgLSH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kc9BmDytscUXZduAdFTphvYJGuoiIHydNXKPeeb1Co=;
 b=Qia7u365cwGF2kYbpwu2jlkWQvqg+LOjsaYK6hb3XzsIde7QfeSEBgOkkYjTWQyfnJTmzyilLICeyYNs2dfx9DQax5XDRXlcmPL5tZ65/MDANxwjYktz2Yh3vTerNbRVaW8flz33ROshjHSkNZhCYmVXApfBF/M5CFlsql4/KRQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Mon, 22 Mar 2021 07:26:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 07:26:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chen,
 Jiansong (Simon)" <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test
Thread-Topic: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test
Thread-Index: AQHXHuwwYb4sW1q7V0quAKA2IyzNwqqPm06w
Date: Mon, 22 Mar 2021 07:26:28 +0000
Message-ID: <DM6PR12MB26190D975C9C6F60AF8507E5E4659@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210322072231.23096-1-guchun.chen@amd.com>
In-Reply-To: <20210322072231.23096-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T07:26:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dad130f4-ca38-4440-a24f-b89b4cdfc428;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3a175f7-41c4-44a5-541f-08d8ed03cedf
x-ms-traffictypediagnostic: DM6PR12MB3689:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36897874B3B3DBA53C30ABB8E4659@DM6PR12MB3689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oItAak/N+Vw9QBrOPPoy9W+w3Gi537Cx7jC9W7Jt9pJ+OWA/XXUzuftCQjOUw5vWR+cQNi+O27ZD/wVRNL/JXLjpA/f4Z3h1BIa0bpNbJX39mP436M4Baz2FJ50RvlM6UU28rIRoHO1KsF8BVpyOaA3nJIgTOm8Oq3xVth6QueSou0D37rWOuhiUYHSUsxMXqKACW1id0ovnuGh5jpuplu99ZZundkv0j/BVGt+JtCDsvAOUvTfWKIANsb9Y/bzJjvacp5317rAdGfdYREzyJd1Kp2G+3lTEglm/l/meiAjpaEs/2Y0abVuCcdKwFyjxHVDh8ZRjdWX7cG95EMRVKRVm28jWU3Cxbg4qId4t41JZ62KLHw1hanh2lUynjQKdK2o4pxtB73R+sZD54hfv7zKNK1RkSrLeDY/J6uzau/SNKvbqsVeDxF8dNg/ycq8o6QB1dnRQk3K6s69M2FE+VogMijqNnYf2Q5DgLLv9lhsH7ihUytn3kOGZDC/YzAsiRDT8gw7POI/WfSTguUOxvRYr4q1AppOyx9hag+7wXFIItQTekjxWLOW3adaRE5i83kj1iD5tetPbnmwvwG96ZaH4PHLgswYm1OtPk4YtPF1QZUjma+voaKZjgayPvND4/T9AaFf9mG2koR2QYIrp4+C+io7NhKEm8KuPGHZ2tt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(53546011)(186003)(52536014)(64756008)(8936002)(66446008)(66946007)(76116006)(86362001)(66476007)(66556008)(26005)(55016002)(6506007)(6636002)(8676002)(71200400001)(83380400001)(7696005)(316002)(478600001)(33656002)(5660300002)(110136005)(2906002)(38100700001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c9P8G8ytS7KjVGyu33r8ourx2vqD/D3OMK3W8niqgUP12qW8IS3fc7FhK20J?=
 =?us-ascii?Q?VbyxMTCObQus/RXsxjKZ9qWW8GpDErDB0LAlPIQ371SWCUv8mnIG6rFJvHne?=
 =?us-ascii?Q?9i9SQTS0V63O0sa8Rx4fe5GjZaoC+orx4OeBIWJu6mteAUkIhfDDVuGTbTpv?=
 =?us-ascii?Q?0e+jQRnPtFROy/XidukunwlW05QKoyteah5skako888OtYNo2bJe7oDnmWXg?=
 =?us-ascii?Q?lN/Q7S2QYQ/bBrAKw/4ub8VIPKAVS2+qoSsi7MOJnUnoMC5UJRLjbyh3itlz?=
 =?us-ascii?Q?N1PtjkUU5XIBHmAedyAElOu2kttAB3Nocoa0Cm/MSRPmEU9wAjYYCWrXISmw?=
 =?us-ascii?Q?/UdALt+PO1Gycg6Pmn1lr7MwIUu0Q/oBGRcNoOXO7iI+kBx+03GA0FjXYfwV?=
 =?us-ascii?Q?DdmvCioZ0SmEpYYOIsxH1hvBqr3UmzxO2Vl9URy2swAAGtu4Y0/4dgYt9hbg?=
 =?us-ascii?Q?rHnxA9ZR+ZW1Bo/qjK+kt232iaDmZ7QjP0U8c0jG6POhybDf4GAEyuhsvc/I?=
 =?us-ascii?Q?oN39Y93YICJ7Q0g3Q27k2NKwI+nTIXmzQkILFH9wR2ZhfBOoym25TROYgP/6?=
 =?us-ascii?Q?A2WGIhfBJ6fysZuJUmYbrY7SViU/uz34e6vC7YOl0nRbJ8Gbck5coPBkKHRu?=
 =?us-ascii?Q?ITtC9+pd+wO4mlDEr0A1ZKrRhx6rk/LwjdLoVuI8PgKmHnnPOtc0wElOvBip?=
 =?us-ascii?Q?Kq5y0niGH6bEQ/Q8DydAeKkwEB1eZwFkBOunUMwCcKlzvUeGU+U5k6CpW1+9?=
 =?us-ascii?Q?sQoyXf4Ml6VElIvi7jQn32vy3UvtJPC0+Aeeb8zEm0MYNSOPtWAOpc6vu8Wn?=
 =?us-ascii?Q?nqo2ENlriEH1EhAjHjeHVmxQtnhE91+R3x+4GPBRGxkvS/ZUaI1TkKT3Ur8X?=
 =?us-ascii?Q?I7cY+M4rrYF3rmN24j2SZPftEGk0tOHBi9B7MaO+kmVuQeY8cfoRdWtMHhff?=
 =?us-ascii?Q?b5jwbmH5dsbC/NmAgjKqVTedk16noxaln4b47N2a0jP0SggRiTFYAisu36Ot?=
 =?us-ascii?Q?vK5CfI3kkjUopkX51mFf8OiEjQB8XDLccNIIosU30yDuaHgwwPpXLX8iZrjJ?=
 =?us-ascii?Q?+7x3+uDRl9nZ3kBOmf841lPscKOiKsrC+0PdRP8JwU+MUvqBkKtLSa3vcXTF?=
 =?us-ascii?Q?1i3QsmHTyiLEmTElatzYP0Ncs7OnbnvvVNP1fAgZ1OMjnmhNiYCfJlS60UHE?=
 =?us-ascii?Q?ZoXHYd7bgwJf7YtRUxxR/KCUTLvhH6hJgz+O6eAbCXkmkhlQZAc2glYeBGWZ?=
 =?us-ascii?Q?SHnztFZPOG039QLaGt/CSzIzcdzKMluHTNLwawCXB0O0bKGq9eYKwnCJOKhm?=
 =?us-ascii?Q?vl9nK0JtipUGsWHHe/gRFfNs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a175f7-41c4-44a5-541f-08d8ed03cedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 07:26:28.3023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFO3KP3aJikQn/kcHbTADU5bQggm8bqe2T9RQUTrieDQz1XMUMhWjXJuEUgp4Vtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks! Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, March 22, 2021 3:23 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test

Skip PP_MP1_STATE_NONE in MP1 state setting, otherwise, it will break S3 sequence.

Fixes: c5f427745ecd ("drm/amd/pm: fix Navi1x runtime resume failure V2")

[   50.188269] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* SMC failed to set mp1 state 0, -22
[   50.969901] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   50.970024] sd 0:0:0:0: [sda] Starting disk
[   50.979723] serial 00:02: activated
[   51.353644] ata4: SATA link down (SStatus 4 SControl 300)
[   51.353669] ata3: SATA link down (SStatus 4 SControl 300)
[   51.353747] ata6: SATA link down (SStatus 4 SControl 300)
[   51.357694] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   51.357711] ata5: SATA link down (SStatus 4 SControl 300)
[   51.357729] ata2: SATA link down (SStatus 4 SControl 300)
[   51.358005] ata1.00: supports DRM functions and may not be fully accessible
[   51.360491] ata1.00: supports DRM functions and may not be fully accessible
[   51.362573] ata1.00: configured for UDMA/133
[   51.362610] ahci 0000:00:17.0: port does not support device sleep
[   51.362946] ata1.00: Enabling discard_zeroes_data
[   52.566438] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126316] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126317] amdgpu 0000:03:00.0: amdgpu: Failed to SetDriverDramAddr!
[   54.126318] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!
[   54.126319] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
[   54.126398] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
[   54.126399] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -62
[   54.126403] PM: Device 0000:03:00.0 failed to resume async: error -62

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0a6bb3311f0f..15e239582a97 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1027,6 +1027,9 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
+	if (mp1_state == PP_MP1_STATE_NONE)
+		return 0;
+
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
