Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 02:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2802054F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 02:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fhan3KxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2802054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835EA6E89A;
	Wed, 12 Aug 2020 02:17:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3578E6E89A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 02:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVjOCGvkPnVrHlwqM/D2QoQZ4Us6dB8Gde93fc8z9VJ2OLDOLJdfU5BpdiIBa1AkO6rCquXXEo3p3V/OhXVQKoMUL5TqTyVKFLcmaIa/Hm7XgIhkciSyY6C33VLsVF0Wfn2tizhAlLgjNniWYIXO/iPkGNtUmIOOYQxqRQIojXVpFVCqPu5BGCDlSVcoenh8ZJ7W5bf7QLbDqNojQBfnIzVbjwOTAQiwL65gRDt3rBQ9swkUTAyzlXKI+QdtD7vQzR+4pvPwvzczeorhpEbRG1Nys6gXPMcDQqnI+Q/kRrmb7MLP0ukB+v3o7iphnFhNQofuHJN9q3kcuY9zjUC4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTrMMBr3eutI+E4qFMFU9+39IT7oiUO//OByBnRrsHU=;
 b=G2ykQjE9QYF5EZ+Rej06WGP5z2XC9KRFBAaChSOzb/bGv+/jdKTjefgpQDgf2H/LwsT19w6mONmhmXbRdLKy12MYvMyd3+3BZzBbmYFB3Nnl57KMoYJuqZGVOhSab15vsH0FtuntXpQYcjNCWj6BZrHJtdNeIyHe5tWD4bf/8mMWZdWyHueMG38Rcmais3B45sqpVKqjZ+pa9k+r48nocWhSn7qg4ekIQvd8r6cND9U4PkhT+HTOYykao1JiiQW+Cb7LQGVBLbdtpf1RPCWOZeAtEfumk9jXCwNOM8DhQCgwYlMlECs0/fdVPC5XiwsuDha8hFxGB4CxgiDbBrqSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTrMMBr3eutI+E4qFMFU9+39IT7oiUO//OByBnRrsHU=;
 b=fhan3KxARWAmVi82w9u42z7uN+LGE59EtrGEpiElk4IzOPRSOIRxea/YpL0m0uSb5r9n8BWuh5nNS1w5epDw2cGL2uyGH6rbfMpCk8ytMbhsyuh1hQO8VHk6hY+W37xEFWbg+y3Bj8nRdEYUfUibQiZBYKUhqrGRrInLFXEcoPI=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BY5PR12MB3732.namprd12.prod.outlook.com (2603:10b6:a03:196::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 02:16:57 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::9d6:20c7:9b15:d650]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::9d6:20c7:9b15:d650%5]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 02:16:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: note what type of reset we are using
Thread-Topic: [PATCH] drm/amdgpu: note what type of reset we are using
Thread-Index: AQHWb/k18wrJeSIhtESfncsO5O+kP6kzvHWQ
Date: Wed, 12 Aug 2020 02:16:57 +0000
Message-ID: <BYAPR12MB2615C8A024AF4480DC52C270E4420@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20200811160457.1073325-1-alexander.deucher@amd.com>
 <20200811160457.1073325-2-alexander.deucher@amd.com>
In-Reply-To: <20200811160457.1073325-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=afad0d36-9f8a-409c-b250-41c3281271cc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-12T02:13:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8aa840a8-e95c-4873-a930-08d83e65ca30
x-ms-traffictypediagnostic: BY5PR12MB3732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3732C2B058D88FECB89044D2E4420@BY5PR12MB3732.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OQ5k0Jdh7yybOBPQo9YwUTB1ynYYOq2GgZKU1xkqdEjMLJVg41TUceXWwt7C2CRwUpTQmXFwXqbGYnDI8e/9gQxmp233qWR0qDRoLCoXmwZcP1faBAu5JAeu+UdjZ5ST+71wKvfPADdVi3A0IKKEIAhWkuk5+WIjuDPtH67xvjrW3/byOY4UONK+X+AuyhyGc45iN5+/aJ7IdOXcTTFe0ZBCkzOq0JAemqh1FvNmAZF+uVdzi9gaH3K5NRQY3iNSyr7SDYdOwMjdLXf7bfwwAaxeXZHRW25m7CD3ovTF04L5VxYDdJ6U7JZM4/vk64yYUR0AQEPBmxnli5hZ/nTjdtEPclQ0s/EfrimJOFrz4I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(136003)(376002)(346002)(966005)(55016002)(316002)(86362001)(71200400001)(45080400002)(186003)(52536014)(9686003)(478600001)(7696005)(6506007)(8676002)(110136005)(83380400001)(33656002)(66556008)(66946007)(8936002)(66446008)(64756008)(2906002)(4326008)(53546011)(5660300002)(76116006)(66476007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PmnLkczgTAx1Q4o32DoTSbSRxYLE2cOfn2lvnTHcI6SrwJD6CsH39DKFsXg+Q8jq90gqsedPuIIA7/NeG9c5Ir713gkp+UnIezTXPnnYc/RtwXZXIEQzTw5V/Qh+mOwuDSDTqfZ/P7dcVCea6/X3UoDLWCmv29gCtin1IbXWiLIygS5vt6FnCd//PMJiPiavEBOrxuRoiQflYemePoWuhqbhniowCJmFv/IBhBM+eKtJUcvtWu0+Oc9Uo+xUPBssQAq9MPeU2LyFr2yTSUUo57JWWa84Qm3WMYMN5d1mP/KE+iN6oy5XZcLNVJGfRlm8B3zBh8gy81u7FjLTxpIKmAVfAGaUe9ZxuZE/FxFzfPsmKAuyksQVxmRWBnL8rstw3TYurZODrmoQezqOnGueVD6u46dtUl2D1LCHHUoWE1vnDYpmOQV4tYdMAEpR1KbnV76XxGcjTtErN8nrnU81mczAoFwi7+kXDqO/q6lNMpRRy3He6Gt5/42E5duyjh7iUi2KPqOLCIO2i4ZujUMC8SMkRxBQhYVdwH5bwtFuz3lzWCqOiSTZRg9dPienHnd+3sX/u3VtQwYpE/aSJs/rPNGvtJP0ETGflxWcOD2hfGD1zhS0DxK+P9LmDf4wS2nmahwO1FLwu6iTnHiKB1d3/A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa840a8-e95c-4873-a930-08d83e65ca30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 02:16:57.7441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRckJKhguMF1rXb93oxjWZ+V7voAd/mArti+k9pSPPetr+czyxq2Ney/i7y/NQ/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3732
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

[AMD Official Use Only - Internal Distribution Only]

There is already a prompt in amdgpu_dpm_baco_reset() about the "GPU BACO reset".
dev_info(adev->dev, "GPU BACO reset\n");
So, debug prompts on the baco reset paths may be not needed.

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, August 12, 2020 12:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: note what type of reset we are using

When we reset the GPU, note what type of reset will be
used.  This makes debugging different reset scenarios
more clear as the driver may use different reset
methods depending on conditions on the system.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/si.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/vi.c    | 2 ++
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c2c67ab68a43..7e71ffbca93d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1366,8 +1366,10 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 int r;

 if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+dev_info(adev->dev, "BACO reset\n");
 r = amdgpu_dpm_baco_reset(adev);
 } else {
+dev_info(adev->dev, "PCI CONFIG reset\n");
 r = cik_asic_pci_config_reset(adev);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index da8024c2826e..54e941e0db60 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -379,7 +379,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 struct smu_context *smu = &adev->smu;

 if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-dev_info(adev->dev, "GPU BACO reset\n");
+dev_info(adev->dev, "BACO reset\n");

 ret = smu_baco_enter(smu);
 if (ret)
@@ -387,8 +387,10 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 ret = smu_baco_exit(smu);
 if (ret)
 return ret;
-} else
+} else {
+dev_info(adev->dev, "MODE1 reset\n");
 ret = nv_asic_mode1_reset(adev);
+}

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e330884edd19..eaa2f071b139 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1302,6 +1302,8 @@ static int si_asic_reset(struct amdgpu_device *adev)
 {
 int r;

+dev_info(adev->dev, "PCI CONFIG reset\n");
+
 amdgpu_atombios_scratch_regs_engine_hung(adev, true);

 r = si_gpu_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 84d811b6e48b..3cd98c144bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -580,10 +580,13 @@ static int soc15_asic_reset(struct amdgpu_device *adev)

 switch (soc15_asic_reset_method(adev)) {
 case AMD_RESET_METHOD_BACO:
+dev_info(adev->dev, "BACO reset\n");
 return soc15_asic_baco_reset(adev);
 case AMD_RESET_METHOD_MODE2:
+dev_info(adev->dev, "MODE2 reset\n");
 return amdgpu_dpm_mode2_reset(adev);
 default:
+dev_info(adev->dev, "MODE1 reset\n");
 return soc15_asic_mode1_reset(adev);
 }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index f6f2ed0830b1..f03314300ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -752,8 +752,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 int r;

 if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+dev_info(adev->dev, "BACO reset\n");
 r = amdgpu_dpm_baco_reset(adev);
 } else {
+dev_info(adev->dev, "PCI CONFIG reset\n");
 r = vi_asic_pci_config_reset(adev);
 }

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C49e2d545b7f142d44a1408d83e105424%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637327587186703359&amp;sdata=u2bQddjGudo4uZmZvn3ubj2fstYIxgdLhZ%2FKsFoWacg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
