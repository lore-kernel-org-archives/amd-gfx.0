Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC3C35280
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 03:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836BF20731
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 03:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lmhMMZnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836BF20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F46E1B1;
	Fri,  8 May 2020 03:39:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0B86E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 03:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYp0UjJGlrtANX0F9syLbbpCg7wkj/Q6z4rfKwpe2eIyRerk0+5+3A6JRk8DpBji1Lpu1c8eNvF+Cyh3eJW9fBAaiy410NY0iY6nwnJDgX0e6hsjLp0fljn4eEOG3TeZfWlK+2Frpx23JXC4xaUvdR6m+P2xWfJV0PKXJNBAF7GXe4Gpio4OGsZvSSobHsh3w/+TwSaoh7c3nuzO4ysJxSAW7YVX3QezMaNzvFm5oMB1cvtXYbn3N9VLm4t4tbzTJh9mhpQMQYY59HrfqnNjCOYoLujg2chr+q+TZUDMn4yd2ZQYLKjnx9hNHr1OLTkppBzDj+J2YkEBNXA5iVDaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n18CUPgx8bZdtxCFjmYXO9X+3w/PBgRze07ADrX003A=;
 b=V7CUsau0S9WL4DGuMNC14ls6GpvbgASGgtGXwOpIUrejWK8ldXGmAyiN1ZYiQIfHBygP8Y+dDHnNGKZhZJpxC9Sv2ROKI3j4QXPt4jVp4slJ+K2OCKe59bJg/S2UiTGl604nigNqsDFdsSQzdOzA8C+Ub8k7eTiSistyv+imWhHwswcLPsqkWUvAoUGpwprCkTAbIq5e9+V0gJUnPf7lu3DOONEplfavikPjretVUGFTmOVwdOxd3GXYe9tiy+WdF8uhneXORepK1lmruz23npXCsP50jbaBYJV353btZLo2Pe7xQxkuDDwK4tDzSiNcObDY5ghN482DnNJxK+LfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n18CUPgx8bZdtxCFjmYXO9X+3w/PBgRze07ADrX003A=;
 b=lmhMMZnpmyjkutBm5a4wJbr3A9gvCaCkN6HYCRULXPb7/gxt9/7S5i1wYasg+3HA6iRSqUM0uhkujKXM3LOu2nLscZQykxJVmI5uP5ITBCEmYgLNWLJ84wwzCYZ+GAxzw5POr0TLXhabCWB4uL2nCcKLp0ivUHivx7tJdbiy9fQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3050.namprd12.prod.outlook.com (2603:10b6:5:11a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.21; Fri, 8 May 2020 03:39:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.030; Fri, 8 May 2020
 03:39:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: implement soft_recovery for gfx10
Thread-Topic: [PATCH] drm/amdgpu: implement soft_recovery for gfx10
Thread-Index: AQHWIvwsZanjttRxNEKcb9N7e2HDF6idjlww
Date: Fri, 8 May 2020 03:39:15 +0000
Message-ID: <DM6PR12MB2619FEF1F34395C52AEA61E7E4A20@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200505164216.138189-1-alexander.deucher@amd.com>
In-Reply-To: <20200505164216.138189-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=69724583-b314-4fb3-a7af-000024d20398;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-08T03:38:41Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 497b84dc-f473-4a08-fdc9-08d7f3016188
x-ms-traffictypediagnostic: DM6PR12MB3050:|DM6PR12MB3050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3050A8B242A6899C4A75850DE4A20@DM6PR12MB3050.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOng+wpmSPYSEb2tNGw47VR0GHgCZApZSXwgobbkKWYlDCCp5sr4xanBGdvjXeWQbwh/bFyZaOSss/JprRcSHMkI7UXRlLtabGQkvn8Bw7AIcwr6fA0UK8HVrjHoHYHJVCBWyzjlctS90zuoSz17V8qc6QgDaaSjbphnE3okzE2Jl50c9JxhG9KEn1Wm7DE0t2YBWDJgyIf2LuP4l1Zng8De20gDJSj98cSqa+/7tst7l2y2aTUlxjpkT6MyC91tdNxbKTbuKqXk5+4xPZ2WgaBwSh+66etggeKkDxjFB5GdePdtwz2NAEsTM4bMgTx5kBap06BUo0fRHaeXwupepyXy/Ipsf7+unairnI2wXUudCAz3gjJV9v6RsQ2dw0TRTVQ6Vv9cZaJXGbdkMdC2fMR7vx+uF5cUu3pe7grnTbDevlJ+oVC/Rb9WQ3YydYuVrozsJTp/uAYKY9GzVG7LAac0WyeOM6o7ztDZz+UvHWkF8UzDnepW3BtD48tduVDfE18D/Ym94jnrF3TGFuzmuBdvgJo3IyKuRF5Pdmdqx+cJIBk+Uwv/gEH9HyWH7+c6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(33430700001)(66476007)(66446008)(52536014)(966005)(55016002)(4326008)(33656002)(316002)(9686003)(110136005)(83300400001)(86362001)(83290400001)(83320400001)(83280400001)(83310400001)(33440700001)(71200400001)(7696005)(186003)(26005)(66946007)(64756008)(45080400002)(53546011)(66556008)(478600001)(76116006)(6506007)(8676002)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5lTYulfDsz3K6SRBHXOhKDcjtffMMC500LymLN+8efezNVd1LToqCKasmRuOztqd/Bd7aI1OY/rUKnKd5gZo6NOxV3utZItSqOElfls6grsp3Uv+gLmeFeSIYKKrksVVHHiSU+oKLoK4nvt0EHt+vwVXqdLQk+U7dAlZeu+QJG/KlpfzzVOTB+m9WhrW9swcJKwZeOT4Gp+FqTfDCujHLmqX23X97+2Vqo4uVPaY8eIhJx05fuk7UOt7cSpD/0oc+nxl2Qlo6DU+udZYeLnMfVsrwdOuR6IL6AvU02iKqgZolGmV8RumOv2QVjrmpz4meX7XfjxSc2pyu3ktTxssQNv8gLg7CKsH1pd9ROBmhKhuyqqAiH7chOSktOF33P63t6MSE1j6FNosUXwViICOAl0XbxqH+ZqigwG8ZuvlKXea7tl0O/P+DogvD3yXwFYt/LmqmmoVdy5K9uNr702u5EBBmd3vZLOIvDBe77rWYGyZviwFOeLFzQdh8Wj5T/sW
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497b84dc-f473-4a08-fdc9-08d7f3016188
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 03:39:15.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DVHBxyijdl9++AueOwf0ht7QpCINM3Xc9URANsEYAVfveZ1EFjTA7gN6UEa6pGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3050
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

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, May 6, 2020 12:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: implement soft_recovery for gfx10

Same as gfx9.  This allows us to kill the waves for hung shaders.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ddb485e1e963..27c63a8f698c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7690,6 +7690,19 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
    ref, mask);
 }

+static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
+ unsigned vmid)
+{
+struct amdgpu_device *adev = ring->adev;
+uint32_t value = 0;
+
+value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
+value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
+value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
+value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+}
+
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
       uint32_t me, uint32_t pipe,
@@ -8105,6 +8118,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 .emit_wreg = gfx_v10_0_ring_emit_wreg,
 .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+.soft_recovery = gfx_v10_0_ring_soft_recovery,
 .emit_mem_sync = gfx_v10_0_emit_mem_sync,  };

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ca05c11564652426256c808d7f1134cfa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637242937523172802&amp;sdata=N5Ia6bTtJ%2F4MoryLJqjSuAfefg%2FWNZYfa%2Fi%2BcLvUTxI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
