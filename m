Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B519C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DFD61924
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DFD61924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D69A6E97C;
	Wed, 24 Mar 2021 05:22:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A9788BBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 05:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsm0ProzmtwFANoe3nnm+QY7MAIQ+8TfqlRWsD0seD2aS9Ez18EJxkawkYvV6+X6AAKmgbTOtHGZwwe6YjvEvX8Nb2C3QraFFjwQoOWzrzqIhARw9UZ5q3QLQcdgTVOSo5UUWOqN0Yr0tCg7DaliAakPfk7Tbr2udb6UkDa7yqEM2OalPGKD1mYAFWoZt/UrU8dw1GYIcFn7jkuC57adRolB/6Grnzk7aZ5ohmVzR+VZaudlXOtEpY0oLBzWjBtTlEvS0a9s4JnJRuLXQl0eQQC3wkufbR4woMd1PF6HDV0Oglx5E72WS6rI+Q3Kagd0PslzoOj6y3zIZcmT9LJbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bySBjRX4SIzqipa/625uRGbdPPx1VOnbvNV4uGpOWqk=;
 b=Y9vfYN5vQj2QPS00ujD+VK48Lh9xQciE9npnDIVJAIoSB1vFH1fLdrrVz7r1oiJ77Ec45f7GEeRF3z2zSQxobFvNiAGKikwp+ZE8yRMA5MxQg+hI7nEg1biiaH+Qp7Oxf/oBFllZBugpEiDZjaHUDldOxuIOSS5NI9p+aLn1TqFaUQRF8n8ehCElOmN+KS5Hq8b7mcEpNU0l+URQ0MPRLeNYSnC73bWCnNF//9Pq+QMOsC3h36OKDZnpYAm71xtW6TQh47fW7/+NTnW1QU77NFwTOMqgBL0dC/uzRQRPQ1xNXYpiwTUordUXKK1uil1B9NrxgL8CTPEjzHkND4Wzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bySBjRX4SIzqipa/625uRGbdPPx1VOnbvNV4uGpOWqk=;
 b=cC9lYKLUGTJPy/Wrym484Ety6DEBXCDrKFaTJgTgpA492GZ1Vy3cQlVHo4HhPuUe2CqDVhRehF0aPFLUPejUNZjCO0pvB7D2Fj0EnMIRoxBm4wedslcAsW+ntK5IkAlonpDbE3wC3VXdHpmSeBPUr1JAWrQfkzz5rxKfAOHYZqU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Wed, 24 Mar 2021 05:22:17 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 05:22:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix build warnings
Thread-Topic: [PATCH] drm/amdgpu: Fix build warnings
Thread-Index: AdcgbTOCq7rjbWWtTU+bZ+wP3L3uLgAAGjQA
Date: Wed, 24 Mar 2021 05:22:17 +0000
Message-ID: <DM6PR12MB4075348FF2E68C4E38AA0B15FC639@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4549EEA4886523AC36E8073297639@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549EEA4886523AC36E8073297639@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-24T05:22:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c574316b-38c5-450a-b186-6e72153c6b1a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a7d57d5-dc6d-4b9d-e5e6-08d8ee84cad3
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB405871A61510E6DA3C928CFDFC639@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEHtL4NwNjKMIAGGVPovOh/EIGz7jYhm4iSYdD5TjX3bOqBsHw9uynuEH+Q312gShnon044gXzeiZzVJDiAKW9fDucKwiTDiSBo5fAm4HJUrPPRPyVG1b9jHD/gaCha+cywNy46mrWGazDSJyr3KzEj1mRZxtPZ3/LFC+qqCkokj6PBM9rAlICxXlpyk1CtmHlz/X4KTYKN+lGnZt/Ga87/zhnvpvy0ol7dpkPlN40E2UvOQ+kr2TVNUTKSfLlU7gu0q7pZR4hcv2jKPs8uMfEZBJVKw/NdzHIN7i3+nA+XXaE3S9USQV1qK10Twe062Csaba56USjbXqbOlLDAYJ1uwPMytHC/xdb5PDxXx/IuRpfT5jlVRAYeOf3R8jhyj90wJcWQZ+Fhqh6RfOlnP+JKAdqcnaxQYPmRx/OWf6lZHHMwsQh1CSEvYr6vdJ6o1DUzlV5K1VDBA6jLuiVeVvuIQ9EU5z5xv9ROi789wftW5Cw6kUxR1y2gYEHpJ8+oiy6Wu4dMfUClHSNFmIK7rjhXCCr7ymE271F3AtfB1ITPfpS9kn7Mx11YWOF9RNskd7aPkVewcL1e+19yHgm15GAWonoFPmXqjQR+P3ecTFT2FtJGLww5rrCh/pn/KIdlcuDk2jtSX37Ue1KrptzJlauS3GA4pKPaNfcg9RrAEGr8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(186003)(5660300002)(316002)(52536014)(55016002)(8676002)(7696005)(66946007)(8936002)(110136005)(86362001)(26005)(83380400001)(64756008)(66556008)(38100700001)(66476007)(6506007)(66446008)(4326008)(53546011)(33656002)(2906002)(76116006)(478600001)(9686003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ru6fHnTAVRX4RUw6UcAAXcgPq5gYxYjyolewjD5h/XIAfycoyD8kfRg8hdWo?=
 =?us-ascii?Q?WaEoKtXzd6XzFvr1JYgbnmZ7EmYtr0sQ5NEZBMGAgTk0ZhiMIAgXWdHIlHor?=
 =?us-ascii?Q?wNc35kjIgILzkTpuNrHH9eKnl4+XAHrYj9wfY/W9rnxl9hsKarIFp3pSczi5?=
 =?us-ascii?Q?XLgvezM7MM4JiMY9VVtyfNDgoV3MBIZEvYcSsZ1Hd9b0YPPYvwM/sp6gjHZP?=
 =?us-ascii?Q?9KrQalRk0FdBLHFPkiIaWkneRu6m4uCFxF47wVx2U9uMgL7a/LtX97VF/hqB?=
 =?us-ascii?Q?qk3rl7Vh2UQsE4C0SeroFHGBWagFDARxNgqerTv3iokB7CR4x5uPZDlUVAls?=
 =?us-ascii?Q?VSf9lW21uu3DlU/2ZU6Gsokipg6NXVNGs8/K9/yYO5XcV2fm/JBVjsOftl1J?=
 =?us-ascii?Q?ftW8HCPWD/adrMre113qSWWvPjvLbWkBK6cn/xmxA6CArktnC15BvMSpVb2k?=
 =?us-ascii?Q?oCAzBxG/M1G5AdNNry/sveoqkk1X0ns//b9H8f93cfp7Axop2YJfs092B0tO?=
 =?us-ascii?Q?xhzX2T9nM3PSrmq5T67h7xE0GIFfAQ+OtIP0G5wIyrIT12r+t5YFISDqO9J7?=
 =?us-ascii?Q?hvlPCpRq0U/O395TL27EnEzOyVy6nRL32cWv37XNNdaHaCVOh5iJEqdX0UbC?=
 =?us-ascii?Q?XFoTMkP/doXUhlNuc0WbQBDe/KPaUY3QN+dZWiDGsSMsb3NTStoTeReffwqZ?=
 =?us-ascii?Q?mmnAuaDsGI4H1tXXP0FLFtGTQ0TZHksQkIInDpXsHeeZj553YVJc1wMfIqN9?=
 =?us-ascii?Q?Jb+sLyk6uioaxHITvUdM5MIB3Cw3AUZ/d0TxUjOcSFiyiofH5ft9BsYHFpli?=
 =?us-ascii?Q?ioZO3LO30onJ3feptn54QMQ6kr0+pWEpoMjeGuosw+eYFqOBuvCyuoFQusXW?=
 =?us-ascii?Q?QKZQx7WwL8GlHy74R/hh4kYexL9WmaSxebHbpRszEDJzkHMJ2EtGxmKuGUUS?=
 =?us-ascii?Q?nmoIYLby5Q9YUom9uHR058uTT+Bwj4mftM/ZfURIbNbPOmJwxZMO9+WygMie?=
 =?us-ascii?Q?0PqdfsMM7Xr0vr/gaI+Ogu2tQpVfXDo/ntSPEfHRZBShIRtcIQyY9Vn5RqmO?=
 =?us-ascii?Q?GOMztb1o3ahJ891J4b8DDXsAN8T28JrMn76kj3kjWWbMz3SBtZutjAuxy9UR?=
 =?us-ascii?Q?i/31AwTZQ2QfPrFf97oXFCPvgrefEEgAiYqH6+c7Nztqq6GaFsG5gjw6+tBo?=
 =?us-ascii?Q?xz30rbKC8RyBSE8/X+PbSz8PngMs2JhBlusC2PPyHFhc2Ua1EyoVmhxc15vz?=
 =?us-ascii?Q?YtjiynUmzkMBneHVDy5zFQTPfOYEXCrt9vYbdBUmKD1hmcStqvrH03x5nUwP?=
 =?us-ascii?Q?+t5zihDCwPudGcaHleqyQQXh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7d57d5-dc6d-4b9d-e5e6-08d8ee84cad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 05:22:17.8654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBbR+M0Vio+sUwPi1rktUECgdpq1YUm8v33QCQSSr53LaHWvHym1z1MWxt1yQc6FUCensBtGf74+fDvVDo3Nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: multipart/mixed; boundary="===============2033911126=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2033911126==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075348FF2E68C4E38AA0B15FC639DM6PR12MB4075namp_"

--_000_DM6PR12MB4075348FF2E68C4E38AA0B15FC639DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, March 24, 2021 13:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix build warnings


[AMD Public Use]

Fix header guard and make internal functions static. Fixes the below warnin=
gs:

drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:24:9: warning: '__AMDUG=
PU_RESET_H__' is used as a header guard here, followed by #define of a diff=
erent macro [-Wheader-guard]
drivers/gpu/drm/amd/amdgpu/aldebaran.c:110:6: warning: no previous prototyp=
e for function 'aldebaran_async_reset' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:1435:5: warnin=
g: no previous prototype for function 'aldebaran_mode2_reset' [-Wmissing-pr=
ototypes]

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
Reported-by: kernel test robot lkp@intel.com<mailto:lkp@intel.com>
---
drivers/gpu/drm/amd/amdgpu/aldebaran.c             | 2 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          | 2 +-
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 39604a461bf5..65b1dca4b02e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -107,7 +107,7 @@ aldebaran_mode2_prepare_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,
               return r;
}

-void aldebaran_async_reset(struct work_struct *work)
+static void aldebaran_async_reset(struct work_struct *work)
{
               struct amdgpu_reset_handler *handler;
               struct amdgpu_reset_control *reset_ctl =3D
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index dc84d871fe72..e00d38d9160a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -21,7 +21,7 @@
  *
  */

-#ifndef __AMDUGPU_RESET_H__
+#ifndef __AMDGPU_RESET_H__
#define __AMDGPU_RESET_H__

 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 472829f5ff1b..ddbb9a23a0af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1433,7 +1433,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,
               return sizeof(struct gpu_metrics_v1_1);
}

-int aldebaran_mode2_reset(struct smu_context *smu)
+static int aldebaran_mode2_reset(struct smu_context *smu)
{
               u32 smu_version;
               int ret =3D 0, index;
--
2.17.1


--_000_DM6PR12MB4075348FF2E68C4E38AA0B15FC639DM6PR12MB4075namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, March 24, 2021 13:19<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix build warnings<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix header guard and make internal functions static.=
 Fixes the below warnings:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:=
24:9: warning: '__AMDUGPU_RESET_H__' is used as a header guard here, follow=
ed by #define of a different macro [-Wheader-guard]<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c:110:6: warnin=
g: no previous prototype for function 'aldebaran_async_reset' [-Wmissing-pr=
ototypes]<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebar=
an_ppt.c:1435:5: warning: no previous prototype for function 'aldebaran_mod=
e2_reset' [-Wmissing-prototypes]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Reported-by: kernel test robot <a href=3D"mailto:lkp=
@intel.com">
lkp@intel.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<o:p></o:p=
></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 3 insertions(+), 3 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c =
b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 39604a461bf5..65b1dca4b02e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -107,7 +107,7 @@ aldebaran_mode2_prepare_hwcontex=
t(struct amdgpu_reset_control *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-void aldebaran_async_reset(struct work_struct *work=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+static void aldebaran_async_reset(struct work_struc=
t *work)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *handler;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control *reset_ctl =3D=
<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset=
.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal">index dc84d871fe72..e00d38d9160a 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -21,7 +21,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-#ifndef __AMDUGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+#ifndef __AMDGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">#define __AMDGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#include &quot;amdgpu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 472829f5ff1b..ddbb9a23a0af 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1433,7 +1433,7 @@ static ssize_t aldebaran_get_g=
pu_metrics(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1);<o:=
p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-int aldebaran_mode2_reset(struct smu_context *smu)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_mode2_reset(struct smu_context=
 *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_version;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075348FF2E68C4E38AA0B15FC639DM6PR12MB4075namp_--

--===============2033911126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2033911126==--
