Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8D7C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 08:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476D822226
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 08:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MeKLf5c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476D822226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B634F6E881;
	Fri, 20 Nov 2020 08:09:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680196E880
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 08:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANMmAfVWMg97eNEsxWcjqgS2JpOpGKs6Sluc0uvHKHK2XOKnSUSiiVyGVrDfzg8SgBzuaUPkP1PjiKYhqmkPBdgvdABUjlwhwK1M8P4eCxTNfUelMA2aCYev/Kra2zzGW2ePRp8jlF/HVVNGtMpGqbDovfaCseQOlWlmrren4Hn94Xkts3nTTnZ5jL6OtSrXndEBGYeu6URWJgPG894S4MVuHNnIIHxLgTPG7cx9XiTzYOXB4AXwzyUi9stVi8zS09tkeDAuY5hEhsvolVo1L88zSs0ThnKXFyYq2R51lbC1ymc9UUl6vN5dX/GSRHHLzUzCS7qYv6p2MJweGt8Xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYahRqpY4dQ//C+CTXcjIjemhRMxopqI8LufHLDV/o0=;
 b=WIbQiyi10ZuPtE8QCuYtfhHubzcexvNGNpYrUc3WciyLUgkPOqJBthvAEMzMuaYm35U/0lv7Xtiirq6hnMO6Bd2PE0WH+Q4RAyNzWDznR9z42V70ygG8gUsNYLik8MqciOs1X3prRN1/sWiONJ+rjn6vt/9Gxxwl69ZehPWcAFjKXFeVDLc4MImSsE/bYCgbRfrsiEKrR5PxVFXd+tiuD/nV2hsDhkxMETmSao5u76v1+0dfrecBQXYspruZN65GZ7xv2RDqhfTjhhmkJernHqRaAhpFtuxuR/XTb6fy2HKQydIZ+1j8dtUYrFxxJqNURilLYulU0mfQNBgc+s3SjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYahRqpY4dQ//C+CTXcjIjemhRMxopqI8LufHLDV/o0=;
 b=MeKLf5c7HbxjHaHOQcWB7TNwDgqurOT7Qlf8r3RTXf+xiNxzYgWSBqR2h/kWMe1B0mYVHA0Oe1ZAgplpoTbFtxis2LY+BQJLbY0kDH499/CJJ3+GXr7Zo5EA/rumhm2h/Nok4usNDOH7tnwvKw5A+4cZ/uzHumDOCBCGJQ70nU4=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 08:09:31 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::419c:3a8e:3cfa:fdfa]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::419c:3a8e:3cfa:fdfa%4]) with mapi id 15.20.3541.028; Fri, 20 Nov 2020
 08:09:30 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add module parameter choose runtime method
Thread-Topic: [PATCH 2/2] drm/amdgpu: add module parameter choose runtime
 method
Thread-Index: AQHWvxMhnGMDYEEnAUiOpCb4UH+XoKnQqpHw
Date: Fri, 20 Nov 2020 08:09:30 +0000
Message-ID: <BYAPR12MB3640A253DBF0F5FAD33D76BE8EFF0@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20201120075928.104191-1-likun.gao@amd.com>
 <20201120075928.104191-2-likun.gao@amd.com>
In-Reply-To: <20201120075928.104191-2-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-20T08:09:24Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fdd4e48f-23aa-4541-b407-0000711958ce;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-20T08:09:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 323f3597-d664-4d98-b286-00009478c8a8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 685d488d-019b-4667-07ff-08d88d2b9bc9
x-ms-traffictypediagnostic: BY5PR12MB4178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41787FB09088E4442E658E668EFF0@BY5PR12MB4178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82bGt8PyLdOpbySxs8aZQ5zEYQ6Vf3cCgERq+RkezQ92iSlOHIrFxhYrnhEZxTo+/JsJ+GKtVPp2+ti3UWDe01TqLWAYh6e6tDmwl/YYm9eyFu4/+BZS1/OXrGc7mvPAIO4NdD5+loktz/OXM4p8bwTlFe+a3p+tU5vGRZOpIWxdTvmSdIpC41vk06heAXnFV24Zb0GU/FWLbNDr6FKA0Ojpc+Hlm8tHMyknLVqlLh0EYff61G/qU2ssgsSpliGIDvMLr9u3+vhiTMetoljTppGfd049B9F/50YhiZJA74VjVBod70a9fk3A5ezv+gHl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(66556008)(66476007)(316002)(110136005)(4326008)(86362001)(5660300002)(66946007)(8936002)(8676002)(478600001)(83380400001)(9686003)(52536014)(66446008)(76116006)(53546011)(64756008)(186003)(26005)(55016002)(7696005)(33656002)(71200400001)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AuGlVGfxMD+tnNeYmHqIe+mHn6cWUs6JUgL8c3Y1Jl1gZW5qjpjUfApRcRNwyL/idV1sqnJ6/QYbZUJsXppjq0P9SaQ2FrhHbFB1pqq71h1GlRZCwMIv4dLw9KVfft+sQfDTwi6al51LAD1+nLYDUon3N5ACWUmtx6KHo38b8iljXctemAMCLI7lLDkgukwC7O8GSKx3LlSDnTAhKHUygp7/qAN1Ab5VOr6EzUxPJqTDxhcaE3XJU8uL3ucGxVG2Rxnn88VmJ6GCi4oY2PdAMJDPtciRhlLc2lN/5ZXpOIqQNSOIDa3r290QutV4kVeBAQ8avEghzTCl85e7vHaxyv5PLKrV9IMWEN6oNz7/AJyWJDUr284wc+h943AiDZ00UX7zf/Lf+XIIOiKfiDxmMaEaHz1IQk9cQrgWZY2WeB7toPdEwK83/zOACc5H7otvZ65khu4PFPHnGZXGbd60nLLa/HKQYdTJsKvHMfy82HoZsKNZROl8A5p58xMo5BMGiapvgTWIueDr1qO22U28dZBBzqa3pCV5FIaMrI/QsW3P9k1Kj0L1msrjDjS8z2tYyA+op9comdPL4d1afBzOXzonpobNtZUdNUFXdXtAmeEAYJEh8SPYshrj8CmbT+CSyYn8qlVpKjmzmNKY1bttlHLh3+lPrOvEbXDjSSeUjdkim2azhiIIxNSJ/UJVXjEgIln39YeXVfhC6veTc9+TBqChyKzewpnnphjSLRRkeaPSef5HrrUWdh/uF6u4VOIsQ8KFHQBrHtQNbLcnNynorum44COBk9O71FMgKdwbCK/k5nXixSi+nxBuxeZsZaKtrKZVEohnPrfqAF2dDq6m/uKMtbJ6PaSSClfH0ActR3tGG2nbZSLK/TKTaK5wLXH8aBZrNxP7rol1bX2DLNqWjQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d488d-019b-4667-07ff-08d88d2b9bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 08:09:30.8179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzLH8p23tsVNkcTJiQyfTpLQs3jDiMgFTrVJzPTRRT5URi+hlgG3RppN5WGc2p9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, November 20, 2020 3:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add module parameter choose runtime method

From: Likun Gao <Likun.Gao@amd.com>

Default runtime logic not changed.
Provide an alternative runtime method. (set 1 to use BACO; 2 to use BAMACO) When set reset_method to 4, it will use BACO or BAMACO for gpu reset, according to runtime value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 38 +++++++++++++++----
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7f98cf1bef07..b2a1dd7581bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -304,7 +304,7 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
  * Override for runtime power management control for dGPUs in PX/HG laptops. The amdgpu driver can dynamically power down
  * the dGPU on PX/HG laptops when it is idle. The default is -1 (auto enable). Setting the value to 0 disables this functionality.
  */
-MODULE_PARM_DESC(runpm, "PX runtime pm (1 = force enable, 0 = disable, -1 = PX only default)");
+MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 
+= force enable with BACO, 0 = disable, -1 = PX only default)");
 module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
 
 /**
@@ -790,7 +790,7 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
  */
-MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
+MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 
+0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7144ea4c0b78..62c34a01a3e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1485,6 +1485,9 @@ enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 	return baco_state;
 }
 
+#define D3HOT_BACO_SEQUENCE 0
+#define D3HOT_BAMACO_SEQUENCE 2
+
 int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)  {
 	struct smu_baco_context *smu_baco = &smu->smu_baco; @@ -1499,15 +1502,34 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	mutex_lock(&smu_baco->mutex);
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		if (!ras || !ras->supported) {
-			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-			data |= 0x80000000;
-			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
-
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
-		} else {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
+			if (amdgpu_runtime_pm == 2)
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_EnterBaco,
+								      D3HOT_BAMACO_SEQUENCE,
+								      NULL);
+			else
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_EnterBaco,
+								      D3HOT_BACO_SEQUENCE,
+								      NULL);
+			break;
+		default:
+			if (!ras || !ras->supported) {
+				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+				data |= 0x80000000;
+				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			}
+			break;
 		}
+
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
