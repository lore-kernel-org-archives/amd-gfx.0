Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8494BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74065068
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74065068
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8116E3EE;
	Tue, 16 Mar 2021 14:02:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0136E3EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 14:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1DRz6ywUks7282i4TE4inr1OShYBpSxhRxQ1YcCF1zjphOQDAeQmpPJL/0fr+tVhlJR+nl8Uh9oCre0nSnKAnR1LWeGM3tsmNzjQdSaVOKGAJ8uCygXm6yxi+ck8+d1Mr96vtjxQ5xkAuXWJ0MXP+QFYasJVnPlsJMnYeED1cEqV1mTJgFGCSdOuYWReV+FlmL5XhoNl2MGEGSVcUxQC0Fqh9kXeAdQizca1RXWGupL9tcQffv1o390aIQma+uYbCp0ngk20Y8jq5LDuqIFlncGO0vLcJ6ZaH8g+ZYVskfBPl756RaMkd73DdT9m9GpXq7GCIk1/dW1cCEgZE9gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBpkck54D2Mo06/6qc7zOiaxSD9Md0IjDkpwRlisvSo=;
 b=ghDo39kZZCOd6ciOJWmndionLDaEkEly/NwT6phIyoC20YKLafiSsqNUVkdjOT8p64cKigydnaW36VlxDJ9OC5gcgfERKrMUqjyYJgMTn2S6zxpZWecBF+Sri/aYRvKN+St2f2NrsOs9UADRQLn5a6fFYYP1l6ux/6I5vN/BT8kHAzMNHxGp3UTK5Ek1i5sldnXdvpMqM0PKQDyYquAn/WiKcpUSm7gHqJz0TWiAneGep80F24WeuM72zpx2ycCJVgC+XlI/xUpUKWHVaGM+LsAJOsxFNi2LW92KS/vSm2emeARw+wDNhdDE9xKuLFvycmY2wqV1BaTi4JEW+CqMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBpkck54D2Mo06/6qc7zOiaxSD9Md0IjDkpwRlisvSo=;
 b=QxnR2xL25iF1aaiuf9ysAgx4xClqvYEoIOfEAUmuxw7ZsLNVDEftg0Igo5PwyIbhwquiZ67kHuv9gLtNqdN0VYLLYK4tdu5Puei99KM69yKO8Bho2/JsWXg7960gLAutF49kd6fpTXnjTJWZJDYYzLDSR0c6GdN6CqIqrWovHWM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 14:01:55 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 14:01:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Skip GFX CG/PG state change during S0i3
 resume
Thread-Topic: [PATCH] drm/amd/amdgpu: Skip GFX CG/PG state change during S0i3
 resume
Thread-Index: AQHXGkBfSACcbhV6FUG0KShwzh6tR6qGpQsH
Date: Tue, 16 Mar 2021 14:01:55 +0000
Message-ID: <MN2PR12MB4488D67705AFD36E77647E82F76B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210316084228.471863-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20210316084228.471863-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-16T14:01:55.087Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e575c3e9-5481-4b0c-b469-08d8e8840f07
x-ms-traffictypediagnostic: MN2PR12MB4517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4517CC3F90112899A1A114ACF76B9@MN2PR12MB4517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBB2iCF4PG2eEq4nA5Hj8RLRI+3bTSEj5h9Ni9lMiUwweeck54hwtsoL/LScwaWchSfpOztIjZCJ8lenT6aPGQCE0JoDpoeVKCh6zO/c1XMNjFp2xXw0mGmNxNP5Mz4s2tN6jcHovMo7JoAko1P9/OPdFqwmv3Sc3hieQP5TiATjBvDZiMWnpnLdGZF6iapFMsNY3CUwVCTersQ+j/WfZ2uzSP0tAwOj35rbo8I4L0efAkYZ1FVz79Hg2HMehz//l+I6McaC/cPNPaozxQ1fSxvGXAdL2OpAliPkxuNFFhTCUaxPKMyJxq+Tw9XjVNizdld6JbZ067G1ouPEUWrdWMTHcjEpkIYP4Dndnzu5koXoYJdPDVyJSqZj6xtyHLHtS2ASs8YU+GY7Uu1XHajxW3T9+SZAzKDVrLaHBPnWUPr4Ebv2wF2WHNapSlYSKQEwCbHO8DP1EQiSZ4Q671FpUUFaBxXYZvjtGz3xUHB7+tgbED/XSyg1S5KrjH1Aijxni8wje/FnespIc3/mJ826S4lABXs58rzR9AiYQrnDpTsSqkVCrFI1U4FXt0FubBfXL+Livm7Kby5Of1lgr4yQNAy4ry2qZTf1ASTqd18X6sE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(9686003)(5660300002)(66946007)(66556008)(316002)(66476007)(71200400001)(76116006)(166002)(66446008)(55016002)(186003)(110136005)(7696005)(64756008)(53546011)(52536014)(966005)(6506007)(8676002)(19627405001)(478600001)(8936002)(33656002)(2906002)(86362001)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Tg5KtKvLOoL7PMWvT/JwkysSPgvArk+i0agivokAjjpFpXVi/3v2chUjwyN3?=
 =?us-ascii?Q?aAoZqUZIIY5eZh+T1P+xYfYoqm9S+X2om2n7V6Ev9VE1ccFr7mlg0qEw46RU?=
 =?us-ascii?Q?2oygrM97lkluYPFE73taF2w2H22HMN1Yp2hGz4yZkTdB5HnkhEv6NGJuMWCf?=
 =?us-ascii?Q?c4ycxXtqXc5qPfbzYv44mGe+OS9tnlvfKehA3LvyuwD6TZ0X3+o2xgzoEJjd?=
 =?us-ascii?Q?d/t3EFTKNIuX7YwarnQ4QQcmxbR8ZWMkAcvtNtmKjLO+lr0cJKVt6hzb+Rsv?=
 =?us-ascii?Q?Bd42M7s5iATRf85cOnGCAtingwJcJTsrVeuIIMdVsXytL6Y/z7XZCxCoMvEW?=
 =?us-ascii?Q?HZO4WWx9ku8JHSxr6tR3vke42msC2DgjIywrQlQkx1Fd7k/I16earjFoIe+7?=
 =?us-ascii?Q?3fbZhFelv2EHUw+C7UbHRaFqBAjGhTUB6Id+j8MtpDF0w+bfcGPZwkLcbqbq?=
 =?us-ascii?Q?07IyQ6ylcZ2FatotTLpVAWHFOE+LlTT8e0vrMSbKdyUx1qaQucfIAeKTkeAR?=
 =?us-ascii?Q?puIORAOVMubvi2iDp9zeEKrbfDd8bh/sMa68wTD8V4bDOrk1vC1mIg+Zlfkn?=
 =?us-ascii?Q?hQkYZAeTtQ57b0axrWTBFIeIFlTk73US39P42mZJSSOEkS67Dyp9HP5adrvT?=
 =?us-ascii?Q?OK9LktGru0jyg/g7rsebTejw6TQF0SiOdFQm76V6u6otrQTOK2QZyHeW/s9P?=
 =?us-ascii?Q?r0iwIrsynCEvsYGysS3mPgNgq7LokVukIgx6I+Dl02Zj996UVhiF643lu7Xc?=
 =?us-ascii?Q?phDRT0PBBn4HAuNH0aeDNxbXxZpzFoVOl7zM7zlgLRnrbYpjG6+cwxAGbJjH?=
 =?us-ascii?Q?Lb04qXIasmcbzOu6NopfhW1DdmsnXACtmP1hRfTPPpPnZnqujnGyvGhhHiMF?=
 =?us-ascii?Q?G7qpJ+uytiAfdLgU8kGhozuyHh+69Fo8ogUPXBX+EAyfCa+HJ3KigyedDdpZ?=
 =?us-ascii?Q?KEmR4ffxEl4PXYohqGlhU7HuJz0qx47T6XYq9zPw2IyDm7Wjur1JkxjkNn/e?=
 =?us-ascii?Q?sR8m5dqB3WeO6FEEY3n3k/WqG46q0yVisBKL5wp+QNyho0zHDC6ervX9oCXZ?=
 =?us-ascii?Q?A3oZHKEfi0PI82ypjyN9msATNXc96tz3dcBhOZiTUec+efFAsZLS6v1uFxCA?=
 =?us-ascii?Q?u4NXTGGWbJhihAeMdqZJaQ8s0pXl3KxWODKvP+gNybdKoXE+2253+Zn+nIRV?=
 =?us-ascii?Q?7KapidZKz0R/Bl5rhL5/wBPTviWgX8p7qDSiOUq3M1rynqM61QB8I/bhFzfW?=
 =?us-ascii?Q?qBkpdhqcHxIs0+v/cMOxTk6iSh3l0hRBFa3UVoz7Z1DDgInmgX6XNFUbd0Sv?=
 =?us-ascii?Q?HjAKkdfjPdyHhNKol2Kflyyy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e575c3e9-5481-4b0c-b469-08d8e8840f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 14:01:55.6583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SUj9JddvRG2QKHmsbBfs6roUzLAENnAJVP6r6Nn9DvOhmJPeuUlxG0z1HYY2HL1pzYLTtC44I26rTYG/VNhyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
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
Content-Type: multipart/mixed; boundary="===============0492440465=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0492440465==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D67705AFD36E77647E82F76B9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D67705AFD36E77647E82F76B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The problem is we are not properly suspending some of these blocks in the f=
irst place.  Please take a look at my WIP patches here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/s0ix-4

Alex

________________________________
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Sent: Tuesday, March 16, 2021 4:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Skip GFX CG/PG state change during S0i3 re=
sume

[Why]
amdgpu resume time is over 1 sec.

[How]
GFX CG/PG state change is skipped for S0ix suspend.
Skip CG/PG state chage for GFX during S0ix resume too.
This reduces resume time to under 150msec.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5da112b3feb0..036ca9f0c739 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1040,6 +1040,9 @@ struct amdgpu_device {
          */
         bool                             in_poweroff_reboot_com;

+       /* Flag used to identify system is in resume sequence */
+       bool                            in_resume;
+
         atomic_t                         in_gpu_reset;
         enum pp_mp1_state               mp1_state;
         struct rw_semaphore reset_sem;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3dbee9671d59..4089135b6493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2349,6 +2349,11 @@ static int amdgpu_device_set_cg_state(struct amdgpu_=
device *adev,
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_VCN &&
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_JPEG &&
                     adev->ip_blocks[i].version->funcs->set_clockgating_sta=
te) {
+                       /* Skip GFX gating for S0ix during resume */
+                       if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_=
BLOCK_TYPE_GFX) {
+                               if (amdgpu_acpi_is_s0ix_supported(adev) && =
adev->in_resume)
+                                       continue;
+                       }
                         /* enable clockgating to save power */
                         r =3D adev->ip_blocks[i].version->funcs->set_clock=
gating_state((void *)adev,
                                                                           =
           state);
@@ -2380,6 +2385,12 @@ static int amdgpu_device_set_pg_state(struct amdgpu_=
device *adev, enum amd_power
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_VCN &&
                     adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYP=
E_JPEG &&
                     adev->ip_blocks[i].version->funcs->set_powergating_sta=
te) {
+                       /* Skip GFX gating for S0ix during resume */
+                       if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_=
BLOCK_TYPE_GFX) {
+                               if (amdgpu_acpi_is_s0ix_supported(adev) && =
adev->in_resume)
+                                       continue;
+                       }
+
                         /* enable powergating to save power */
                         r =3D adev->ip_blocks[i].version->funcs->set_power=
gating_state((void *)adev,
                                                                           =
              state);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index f98843eeb084..693ad3b3e6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1400,8 +1400,13 @@ static int amdgpu_pmops_suspend(struct device *dev)
 static int amdgpu_pmops_resume(struct device *dev)
 {
         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
+       int r;

-       return amdgpu_device_resume(drm_dev, true);
+       adev->in_resume =3D true;
+       r =3D amdgpu_device_resume(drm_dev, true);
+       adev->in_resume =3D false;
+       return r;
 }

 static int amdgpu_pmops_freeze(struct device *dev)
--
2.25.1


--_000_MN2PR12MB4488D67705AFD36E77647E82F76B9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The problem is we are not properly suspending some of these blocks in the f=
irst place.&nbsp; Please take a look at my WIP patches here:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commits/s0ix-4" id=
=3D"LPlnk">https://gitlab.freedesktop.org/agd5f/linux/-/commits/s0ix-4</a><=
br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vishwakarma, Pratik &=
lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 16, 2021 4:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liang, Pri=
ke &lt;Prike.Liang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Skip GFX CG/PG state change during =
S0i3 resume</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
amdgpu resume time is over 1 sec.<br>
<br>
[How]<br>
GFX CG/PG state change is skipped for S0ix suspend.<br>
Skip CG/PG state chage for GFX during S0ix resume too.<br>
This reduces resume time to under 150msec.<br>
<br>
Signed-off-by: Pratik Vishwakarma &lt;Pratik.Vishwakarma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; |&nbsp; 7 +=
+++++-<br>
&nbsp;3 files changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 5da112b3feb0..036ca9f0c739 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1040,6 +1040,9 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_=
poweroff_reboot_com;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flag used to identify system is in=
 resume sequence */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_resume;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_gpu_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_mp1_state&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mp1_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rw_semaphore reset_=
sem;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 3dbee9671d59..4089135b6493 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2349,6 +2349,11 @@ static int amdgpu_device_set_cg_state(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_VCN &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_JPEG &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;funcs-&gt;set_clockgating_state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip GFX gati=
ng for S0ix during resume */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_GFX) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(adev) &am=
p;&amp; adev-&gt;in_resume)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* en=
able clockgating to save power */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state((void *)=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state);<br>
@@ -2380,6 +2385,12 @@ static int amdgpu_device_set_pg_state(struct amdgpu_=
device *adev, enum amd_power<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_VCN &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;type !=3D AMD_IP_BLOCK_TYPE_JPEG &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version=
-&gt;funcs-&gt;set_powergating_state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip GFX gati=
ng for S0ix during resume */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_GFX) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(adev) &am=
p;&amp; adev-&gt;in_resume)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* en=
able powergating to save power */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state((void *)=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; state);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index f98843eeb084..693ad3b3e6a0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1400,8 +1400,13 @@ static int amdgpu_pmops_suspend(struct device *dev)<=
br>
&nbsp;static int amdgpu_pmops_resume(struct device *dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *drm_dev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to=
_adev(drm_dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_resume(drm_dev, =
true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_resume =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_resume(drm_dev, t=
rue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_resume =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_pmops_freeze(struct device *dev)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D67705AFD36E77647E82F76B9MN2PR12MB4488namp_--

--===============0492440465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0492440465==--
