Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B41C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8E32065C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dyvNzxF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8E32065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6783889208;
	Tue, 28 Jul 2020 06:48:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAEB89208
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 06:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA209/8ikjD7BK26frXU+nuTD4WUdoeEXTSq6V6SGDwfbeezpF9D9ZfGoyFwsEeJ6Q2ZY+HvkVSv8ns3Xrz6gOagRW3/t8IIL8Oye03ws7gDDwxlE4hlkRGZf2ZsnkCGGxYOYTDYbs+kqk9zo4OiReU9JWeSR9waeUjpuX2YUXmqWUlkCLrIqJCSUJoRo0jmiLmyJMbSrMZ528xbDSr+tV6BJB8USnCFz7MKPv2B1kVjtPJqWReqLopCXH6Hp2CA6NKYLRlXCC5133YpI+A/XH4pJPWJEpc6vTMPRD37uLIo3mSlB1xJwj4fZAGsRTRpFQqq01oQBe0CDrOX6D6HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXOK64cB2Ibs/dyVOZISJjW2dAfTZwXPFk9Wc4YRruY=;
 b=Jl8M2B/7mWXWV/QtCAn8ulT+O/pXlRF8Wc+ItkJpgHZodd0EupdHszsEj8P1FSWKJvhSlhL9WqzcBxGFlrfbfg9TC2OkmRxCSahfbvflcbv+B87fzS6xEPyHcR6rTmonvnini8w67faSei+T/ST6wJBLOv+jhc5zKuLTTvh8vUXX85nCChft4toBlDPpKqLGiWW5EoERkyCEgVl/j07muWQgr3YMZCH2WFfDAU5bEAGwW7VQT0zhmQLXCkcpBVFuW4HmI6toaXLrtx+p8a2PIPH6KsBaDmCMCrLdUsVNp0D88xWqZz8IdJldcneVlmh/0b1eFIjTinuBJW5jWUq6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXOK64cB2Ibs/dyVOZISJjW2dAfTZwXPFk9Wc4YRruY=;
 b=dyvNzxF92C9moT5jR5ft2JEd8ynMXBIQ2Dl7ijeHGiLyJd3QQbfKCNPgUAIoSP9P910THDoKXM1/4byv7epmOOagijo4DH/ZfD3DRQs+o6VaZXkXo0tecpQfpoZCDw2FsHkUrbYFu2+TbviDYaSo6CvuUZnswLpTXrMEXDVQiaA=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 06:48:27 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 06:48:27 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit
Thread-Index: AQHWZJ/JJnQa1rfOrkiiEaG9S8S0L6kchsmAgAAFUQA=
Date: Tue, 28 Jul 2020 06:48:27 +0000
Message-ID: <BY5PR12MB3777F1A866D54C2569A8EA0E95730@BY5PR12MB3777.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>
 <CY4PR12MB1287B8C26F31BEDF70130C35F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287B8C26F31BEDF70130C35F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T06:24:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=83d23519-abd0-4b2d-993d-000020fd5e75;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49f31c57-70c8-4fd1-6249-08d832c23b7c
x-ms-traffictypediagnostic: BY5PR12MB4113:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4113152FDE174794B6EE7BE295730@BY5PR12MB4113.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2k6P0kn8IXN6qZrZzw/FpIamoKdGOp7MIpClSO3YUHD1UClDR11Qxh/YHbyljg6lQ+/gMVQqsrwm0l8hme4RpVL0GwDYpOA7HBZbcdlub0tZZuRSaOL3i9fbjUGx0fnH3pEOrAB8RuITyvAVBSCOhRFxHR33QecFoPwyGQU8K7qpE0LFmcIXT5auCsKZgdoZD70QJTCLssa8TZn/su95TX12WBfsezJ7RK/CHm00tGqgYsVuuRJ4qC5Pl4C1fgxoBr54lT08Z3/NSBotiNnyOTRH/dFQ7DHv/IbCBrndt9uGu7DV/tJ+/gLan8LcblZ43gaaVGGfjhSXicQfsiSO7JwdAlC0phX8aQwaD9XYWei3CF/w3VBNo86L4pOScQW+/7I6YxwnB3sywhc7/UhAjyqjpOE98v4o0mvewTunoc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(110136005)(26005)(2906002)(966005)(6506007)(55016002)(4326008)(53546011)(186003)(316002)(66946007)(45080400002)(76116006)(478600001)(66476007)(66556008)(64756008)(66446008)(8936002)(52536014)(83380400001)(5660300002)(33656002)(8676002)(71200400001)(54906003)(86362001)(9686003)(7696005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SmE9p+8AtFFMD4GIY3zLiDXz+qT+KKe70yDBcu6pBzcLwN+TWLWYcZxxMSHp32d43QDHnlbWHApfQW860SkYR8+AXFLZs+XHZoGQxoqePAp7awPGu7rvuOBnNNTcXOeWRw5iYyF9TdR1au6+A0LcjzOWRxSSNdtkEDfYQvYvgro015gyclMFSIfwCqoYRfTK92RO0obzihj689Guc/AkpMmdLPCyroijsWd4YTISOi7Mtu6Vh+J9JcRBY4oocaM+DPGLg/tCr848t7m901O+dgAZprneXKSm9Ma6VGPszHzJfc9b/R0vjmXuA8h4v0Omua53zbzcFvrnfW6dfmE9zhbou0pfNvDgfwkl9olF7uYtvVzoSoAERSKEy9saPzEDe/SAaQ67XIUQTR+0T1QRXow1nEvuIsh/Pxiy0ZcdJdystIKMlkwxqzovNWeasPxDFtOxZ3FjlngPqcAz0d5zbnEiKo74up9AqHrgjqkoe3NCnaCLSZCwRxXYySweuhxk
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f31c57-70c8-4fd1-6249-08d832c23b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:48:27.4207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVwHIRLUwXEH4ibG3xM2v99Gl+qreWOLO4JdOembKqQ7sFf+Ke4+vG0qoJCRgYgR5LYi6AmEE2X8tv51zvsI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Hesik, Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Guchun,

Since the adev variable invoked a few times, local adev make the code more concise.

Thanks!
Rico

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, July 28, 2020 2:26 PM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

[AMD Public Use]

One minor comment.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Yin
Sent: Tuesday, July 28, 2020 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit, reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..5da0436d41e0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
 
 	struct smu_context *smu = (struct smu_context*)(handle);
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;

 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
[Guchun]Use the local adev instead of smu->adev?

 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);

+
+			if (adev->asic_type >= CHIP_NAVI10 &&
+			    adev->asic_type <= CHIP_NAVI12 &&
+			    (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+				if (adev->gfx.funcs->init_spm_golden) {
+					dev_dbg(adev->dev,"GFXOFF exited, re-init SPM golden settings\n");
+					amdgpu_gfx_init_spm_golden(adev);
+				} else
+					dev_warn(adev->dev,"Callback init_spm_golden is NULL\n");
+			}
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Ce6176c766fe747a6fe1a08d832b6ee3c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637315108573876551&amp;sdata=43GHkX%2FCRLsfMmNxurLMIZy4l4ElUB2tnslPyfT7NJg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
