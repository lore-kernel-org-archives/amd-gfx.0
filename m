Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD4DC197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 11:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C136810E74E;
	Fri, 17 Nov 2023 11:56:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39CE10E74E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 11:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYPtmEeBj2+KPPLGYJZDHLfSPxgzrqEMt6oBEAaPnpXMbeIBJHY0uHEGWS7n+JuqedgwKNx7yq4pUBKMZ+WIDjEUUYTwr6/fwahxMcvpttz1vQhL1Llmp13yVcGwxnv2fqOoHCusB9dJfmHUuEv2IYq8lsaO5m5pfZZtKWj46qglyFQDGtTDcj0mUfOs4qOvGn7mOtWQSXApAgLUjSctxj1j/X0VOM6B1E1URkSvETRJO8VgpjaNnCahtsbsaPGbGTjxwcNG7B8TMHEy60s7Fl5uKkX2CpP1vlC5QJ65areiSV+x2VTwxd4HppPgrc3IjfKTLE2mSw+FL8CXHlGdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xvbDwyaB9EcAY0rDDDwSKREWXrIrcOUVoadnNFBkBg=;
 b=NnHpn464L/rGSAnZLYTcl+EdZ0CV23pawao89A1/0hPdMrYixqgJjQLkIcSEkJTutAJvZVIxqKzihCjCZZW4aymd+qb+8D39Kwoqdf5yNCMUHQOc35D0aY4HAX/DMZb7lxfcKmh7GqQAsNJJ54rXNaE7KzraOotn0NZMloqVw8OpuE5F1N2ocMVyoPId7zxo8uV9GtWErkXopwAg5R2rfMAB/cl7I4UuZQ6GuMAtQ+w/TCuXv+nhAaXbyKmc/5E4RqunrRug4R5yrkxCVDrn1pMbVMUUy0ixZySARnoKkjF1wNsi1XTWOhfmffiIpfX+39ZevOdUUtHBM6uLG6iqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xvbDwyaB9EcAY0rDDDwSKREWXrIrcOUVoadnNFBkBg=;
 b=x3Mp7eUcswe22gQbDDCMwHSFaK4sJrGfmhcneZjjXLoaipXbQfzxDWCPf2Nk/FmNpB4qObSFlslDhyxhrA/ooi+ApkXfnzu437hFh6fwzO9TVXNZIBPTLk4gK3xZYjyUukM0E+fI7OYUSDWvVJsZ7LPuj8xxzrJyDmyaJqEmkLY=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 11:56:39 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::7b2b:ed83:1f7c:7498]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::7b2b:ed83:1f7c:7498%5]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 11:56:38 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/6] drm/amdgpu: add lsdma hw ip definition
Thread-Topic: [PATCH v2 1/6] drm/amdgpu: add lsdma hw ip definition
Thread-Index: AQHaGPtJxcd35cSJzkuOZHrhlTmbDLB+ZsyW
Date: Fri, 17 Nov 2023 11:56:38 +0000
Message-ID: <MW6PR12MB88987C823BD36FD9F7941F75FBB7A@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
 <20231117020946.2912865-2-yifan1.zhang@amd.com>
In-Reply-To: <20231117020946.2912865-2-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-17T11:56:43.638Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM4PR12MB7717:EE_
x-ms-office365-filtering-correlation-id: ba86d0ab-19c0-43d3-f41c-08dbe7644163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6R0RpgTzM9D06PIMZ3LuP6+tT0cl5QgdiiAhrWmaIHiOLULiLMPv3IA/W3fXmibJriU7IuWqWesLLUYBQEZwMYGYj49bLLryaTulSH8tH2DDuc71Cz869aQs5U/Br6huvJl0HSxNq0FtG6lWRL4PwqaJ0f9IObxYFmmOd7J5mU2GFXoPTQzLnIoFYwcXfFahO15BAurTCHInV8NCY2hqujhfuayPm0wtBllMFTuf5iO+O0v794uoKUeGDJbeKrq/grMxHQsfRztu2K176XyD+GkUiLfm61Vh5zOSsyPSmjEUr+CmzFh6PmjdDdtxRNaLxkbxffZ+u/5lGmX59CjEEqOtSinkFwHg7jRdqDjoUnpymEKSLO4kIh64jNNXSfY+KjsI59rWla8xiQYq5VA7B269fp9z1rZLyzumPI4OXRVu7FiaHe2ktfqHanpwsttm0Hz7wgPJ/9P1veoQDHIRibTfkOFaTV4lUkL9G0HF5Hqq6X5887dfMdNLUiz8/HXC+GjYhYSv0Nsv1FtuLmGQymlGW3fOaBGvq53kciKbNRSSJHJCjgUSJmDzm+bAhwFfW26jaVLImiiDK7i6NpBmc/uiqr2XPU6WjgnDMbYosg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(38070700009)(19627405001)(122000001)(55016003)(83380400001)(9686003)(53546011)(26005)(7696005)(6506007)(71200400001)(478600001)(4326008)(86362001)(5660300002)(8676002)(66476007)(41300700001)(76116006)(91956017)(110136005)(66946007)(54906003)(66446008)(64756008)(66556008)(316002)(8936002)(52536014)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?udEclKPCLWH64oXBpVYdXh6Mcwa6dq0B9zUacB/Z2VgjmuhSNx8AH8xBwqRZ?=
 =?us-ascii?Q?tsuKUzOjE59bXG3uA59GVnGHcPF/NhlhRw0ZpCJgnbnJ7IPsTuacOYDaGgD5?=
 =?us-ascii?Q?xfXgE6d+sp+HFlgsipMXEHhG9NOrYfRVsKretfUHtwBkjLo/58Gpl7GWPrTj?=
 =?us-ascii?Q?6zzm3MU1ZW5K9OKg16xBwsyxGB3nbnFg3uipEfZtgNBxtoW+9tJ+xJSmAoQL?=
 =?us-ascii?Q?msQ1ZHhJkbxTFhifFeAzrpX+1fJvx3CZU/4CCxuLYv5MzxQxTMWYLIm8oUn3?=
 =?us-ascii?Q?fOpS50USFNVlhRFsMjLHyLawOxhpVdKC6wMWDIgjyxln11RtBjXQoUimJJsS?=
 =?us-ascii?Q?vuuSUSp46Ouv9IOUuB4ytgeElIiLNnlc5rZx5AOV3c7ZxJ9jcSuRN4jANDrm?=
 =?us-ascii?Q?WlBYXO7Xu89mXPj73NzBaBUXzqBD8PEPTDOUsD+THCmlIXYhs6pMboSNxQKr?=
 =?us-ascii?Q?x1oHton8p+Kz5GrkxvHM7QfFUSjpVFXOWGA+PRFiUQarjJOrrxyC+ue3Ka6j?=
 =?us-ascii?Q?BKqu14zipWJhNxPiGB6DDLuIk4Xx/i7PhQrp51OpU9rQ0KZ4BN9YG6Nid16M?=
 =?us-ascii?Q?xvf7OBHt0Zy3ZuOWa6dMs4botmn7KR1r9YJypk1lNk1jZ/ikSYWkL92sRydn?=
 =?us-ascii?Q?H0I92o8wT+rhUQHDl5miLKOu9BLkUcxSXTqXGEKeo45j+xbDAOH0NXSbTiD0?=
 =?us-ascii?Q?OFqmkTSM40J4AJIvAbyvY/PYYB2v7hYNx5IjlHwaP9LEqVhuY1w7h9B1Yp0d?=
 =?us-ascii?Q?dbxea0uNzQAunuLEyoxk5yJ9iS0/n2z8yi11uN173LW/isrOM5vjDAaLJV3O?=
 =?us-ascii?Q?Jz2G0Kxz+sYbxPv3WMGlNNi/iImYC62zeDWltEKCOiN394vDIwd1fPM2U4Os?=
 =?us-ascii?Q?UAO7xgdu8zd4tolP6Dewlc1cFT2ptEKDS67JEJWoKzYCwiA2ozHp8/jpVbSQ?=
 =?us-ascii?Q?kf+Zml9lkYfE8TooWnZoRDXpfCke2pCaJ+19Xl7KANjhlQMqbxnArNg05Zua?=
 =?us-ascii?Q?iHEuQprRrrceAHOP2ZJ1n+sVMh3TAI4OFiKStXPsuV13IvxY5Z+JCRvO/q2X?=
 =?us-ascii?Q?T/jI0bhJX02rgyaEl9HD6dnsJxPsjcwmbQw5GYZm6PnFIkFbI+G2az8vNJO5?=
 =?us-ascii?Q?+05l1GvjdzTZiI3V+MvBydAUJWkESO5ChBW7y4LFDEkyloKjd6EAoPow8Df2?=
 =?us-ascii?Q?PNnsG1xAKFYWvjAlN4W/cuBGoWZnTmz8nnlEH9gGszP97+skcWhChMwz904B?=
 =?us-ascii?Q?iuMgLIspOjJgGcsGUsqGsPRKlXhZaycj9D/+MbFFHNaP8xc2iQySnNtPpRbC?=
 =?us-ascii?Q?AZ03j4ndh5t3fAEHt6qi1WCEkVNkPT/kraTGkw9RhlVpT8yhUU8f3VruVT+2?=
 =?us-ascii?Q?Ne0Ug+z21Ig7cNWsc292BZoI3sSTOH/mecRbollSh+PMHRKhouQGuumqlZuh?=
 =?us-ascii?Q?brGWpM2g9tKeOobNpuNPr6YaDej1tP1Nl4XFHcZKta+QNblIo4qbJBw4gqRL?=
 =?us-ascii?Q?+kR1E7HzrK8YVK9uNfZg+21ICP5ddAPa7Of6Y5Qij4aiwZlLO1TWv4Y/ZxoZ?=
 =?us-ascii?Q?tz+X0O+Y5YPZT4aCc5k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW6PR12MB88987C823BD36FD9F7941F75FBB7AMW6PR12MB8898namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba86d0ab-19c0-43d3-f41c-08dbe7644163
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 11:56:38.2262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFeeny8LbLX51WKOcK6nFnUplLT9lFFM1pRM6pcp3gKuQ3QDVlw4W39cM6LXH6iXuwrHUbraOpCtCLEZLiAP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW6PR12MB88987C823BD36FD9F7941F75FBB7AMW6PR12MB8898namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

 enum amd_ip_block_type doc is missing for LSDMA.

@@ -85,6 +85,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
+* @AMD_IP_BLOCK_TYPE_LSDMA:
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {

With that fixed the series is Reviewed-by: Lang Yu <lang.yu@amd.com>.



________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Friday, November 17, 2023 10:09 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang <Lang.Yu@am=
d.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 1/6] drm/amdgpu: add lsdma hw ip definition

This patch is to add lsdma hw ip definition.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 15 +++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 include/uapi/drm/amdgpu_drm.h              |  3 ++-
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b49ad7690a8c..bba9e8da2384 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3418,6 +3418,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct =
amdgpu_device *adev)
                 AMD_IP_BLOCK_TYPE_DCE,
                 AMD_IP_BLOCK_TYPE_GFX,
                 AMD_IP_BLOCK_TYPE_SDMA,
+               AMD_IP_BLOCK_TYPE_LSDMA,
                 AMD_IP_BLOCK_TYPE_MES,
                 AMD_IP_BLOCK_TYPE_UVD,
                 AMD_IP_BLOCK_TYPE_VCE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c
index b3630ceaff4c..20519ca90fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -52,6 +52,7 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D {
         [AMDGPU_HW_IP_VCN_ENC]  =3D       "enc",
         [AMDGPU_HW_IP_VCN_JPEG] =3D       "jpeg",
         [AMDGPU_HW_IP_VPE]      =3D       "vpe",
+       [AMDGPU_HW_IP_LSDMA]    =3D       "lsdma",
 };

 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..91ec481377fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -215,6 +215,9 @@ static enum amd_ip_block_type
         case AMDGPU_HW_IP_DMA:
                 type =3D AMD_IP_BLOCK_TYPE_SDMA;
                 break;
+       case AMDGPU_HW_IP_LSDMA:
+               type =3D AMD_IP_BLOCK_TYPE_LSDMA;
+               break;
         case AMDGPU_HW_IP_UVD:
         case AMDGPU_HW_IP_UVD_ENC:
                 type =3D AMD_IP_BLOCK_TYPE_UVD;
@@ -438,6 +441,13 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ade=
v,
                 ib_start_alignment =3D 256;
                 ib_size_alignment =3D 4;
                 break;
+       case AMDGPU_HW_IP_LSDMA:
+               type =3D AMD_IP_BLOCK_TYPE_LSDMA;
+               if (adev->lsdma.ring.sched.ready)
+                       ++num_rings;
+               ib_start_alignment =3D 256;
+               ib_size_alignment =3D 4;
+               break;
         case AMDGPU_HW_IP_UVD:
                 type =3D AMD_IP_BLOCK_TYPE_UVD;
                 for (i =3D 0; i < adev->uvd.num_uvd_inst; i++) {
@@ -546,6 +556,10 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ade=
v,
                         result->ip_discovery_version =3D
                                 IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(a=
dev, SDMA0_HWIP, 0));
                         break;
+               case AMD_IP_BLOCK_TYPE_LSDMA:
+                       result->ip_discovery_version =3D
+                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, LSDMA_HWIP, 0));
+                       break;
                 case AMD_IP_BLOCK_TYPE_UVD:
                 case AMD_IP_BLOCK_TYPE_VCN:
                 case AMD_IP_BLOCK_TYPE_JPEG:
@@ -679,6 +693,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                 switch (type) {
                 case AMD_IP_BLOCK_TYPE_GFX:
                 case AMD_IP_BLOCK_TYPE_VCE:
+               case AMD_IP_BLOCK_TYPE_LSDMA:
                         count =3D 1;
                         break;
                 case AMD_IP_BLOCK_TYPE_SDMA:
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 579977f6ad52..8c03afd4d472 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -95,6 +95,7 @@ enum amd_ip_block_type {
         AMD_IP_BLOCK_TYPE_PSP,
         AMD_IP_BLOCK_TYPE_DCE,
         AMD_IP_BLOCK_TYPE_GFX,
+       AMD_IP_BLOCK_TYPE_LSDMA,
         AMD_IP_BLOCK_TYPE_SDMA,
         AMD_IP_BLOCK_TYPE_UVD,
         AMD_IP_BLOCK_TYPE_VCE,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ad21c613fec8..8edae0f56bdd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -595,7 +595,8 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_VCN_ENC      7
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_VPE          9
-#define AMDGPU_HW_IP_NUM          10
+#define AMDGPU_HW_IP_LSDMA        10
+#define AMDGPU_HW_IP_NUM          11

 #define AMDGPU_HW_IP_INSTANCE_MAX_COUNT 1

--
2.37.3


--_000_MW6PR12MB88987C823BD36FD9F7941F75FBB7AMW6PR12MB8898namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">&nbsp;enum
 amd_ip_block_type</span>&nbsp;doc is missing for LSDMA.</div>
<div class=3D"elementToProof"><br>
</div>
<div class=3D"elementToProof">@@ -85,6 +85,7 @@ enum amd_apu_flags {</div>
<div>&nbsp;* @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine</div>
<div>&nbsp;* @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine</div>
<div>&nbsp;* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia=
</div>
<div>+* @AMD_IP_BLOCK_TYPE_LSDMA:</div>
<div>&nbsp;* @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types</div>
<div>&nbsp;*/</div>
<div class=3D"elementToProof">&nbsp;enum amd_ip_block_type {</div>
<div class=3D"elementToProof"><br>
</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">With that fixed the series is Reviewed-by: Lang =
Yu &lt;lang.yu@amd.com&gt;.</span></div>
<div class=3D"elementToProof"><br>
</div>
<div class=3D"elementToProof"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, November 17, 2023 10:09 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&=
gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH v2 1/6] drm/amdgpu: add lsdma hw ip definition</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add lsdma hw ip definition.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
Reviewed-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp; | 15 ++++++=
+++++++++<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++-<br>
&nbsp;5 files changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b49ad7690a8c..bba9e8da2384 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3418,6 +3418,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_DCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMD_IP_BLOCK_TYPE_LSDMA,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_MES,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_UVD,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_VCE,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c<br>
index b3630ceaff4c..20519ca90fb5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c<br>
@@ -52,6 +52,7 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCN_ENC]&nbs=
p; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enc&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCN_JPEG] =
=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;jpeg&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VPE]&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;vpe&qu=
ot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_LSDMA]&nbsp;&nbsp;&nbsp=
; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lsdma&quot;,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index b5ebafd4a3ad..91ec481377fa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -215,6 +215,9 @@ static enum amd_ip_block_type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_DMA:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_SDMA;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_LSDMA:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_LSDMA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_UVD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_UVD_ENC:=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_UVD;<br>
@@ -438,6 +441,13 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib_start_alignment =3D 256;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib_size_alignment =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_LSDMA:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_LSDMA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;lsdma.ring.sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib_start_alignment =3D 256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib_size_alignment =3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_UVD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_UVD;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;uvd.num_uvd_inst; i++) =
{<br>
@@ -546,6 +556,10 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resul=
t-&gt;ip_discovery_version =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION_MAJ_MIN_REV(amdgpu_ip=
_version(adev, SDMA0_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_LSDMA:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, LSDMA_HWIP, 0));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_UVD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_JPEG:<br>
@@ -679,6 +693,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_GFX:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_LSDMA:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=
 =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_SDMA:<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 579977f6ad52..8c03afd4d472 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -95,6 +95,7 @@ enum amd_ip_block_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_PSP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_DCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_LSDMA,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_UVD,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_VCE,<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index ad21c613fec8..8edae0f56bdd 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -595,7 +595,8 @@ struct drm_amdgpu_gem_va {<br>
&nbsp;#define AMDGPU_HW_IP_VCN_ENC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br>
&nbsp;#define AMDGPU_HW_IP_VCN_JPEG&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
&nbsp;#define AMDGPU_HW_IP_VPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 9<br>
-#define AMDGPU_HW_IP_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 10<br>
+#define AMDGPU_HW_IP_LSDMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<br=
>
+#define AMDGPU_HW_IP_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 11<br>
&nbsp;<br>
&nbsp;#define AMDGPU_HW_IP_INSTANCE_MAX_COUNT 1<br>
&nbsp;<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW6PR12MB88987C823BD36FD9F7941F75FBB7AMW6PR12MB8898namp_--
