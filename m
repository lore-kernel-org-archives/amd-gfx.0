Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3930CCD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 07:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B1B10E793;
	Wed, 10 Jun 2026 07:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WDUVmxPR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D76B10E795
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 07:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl7dkBUeWRwVTOUwnUEysgBueF44rEV6ho2k29n6gROKr7eWzeoze9WfbCPPxnWUW58jxyF45KRTRNs5Y4byWTzOsiznoNhUC9mHBYFmoCLVH4a2wKztVL6cXJAs9ltq802HjSp/dsxa3pzDX0K44nyKZmMUCHJJWukElRwa9Qdc/D8H2XZ0sHSwSfjfQH2/0ASd+ATNrxly3nbL+GC14bRDuUajPWJVs0jTJaucFuJk1G0LqEb2I0sVrCzp9Q0nTA8dQ6bb2p0nSzxGQQ5B5j+VVFZnysiR3UeyZTRurdUIIpXQ3Z3rbGnBUXFPibPJ4xd/ZG8AT7pQ8eWa2jOluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA39owywC4Zl5Dp6jh+54ZkLkSt90w5VoZMien4DE6A=;
 b=P44MebVCu+EuPHeS1VptRWEus8k8fQiSJUKqUYKyAzJOJOX6btqoJnJ0b/WlT9BdBKcrdYSLa3epVLSSirm/kEblzgLvk+lV21MMzzg/NbdURQSgsSxpjUbr5V6+Xu0VIF7DS4QVZ4KwSHYhMylJtSGQBXLIvHHL4+StKe+S8NXj8qACGsPg28O8UWBAYF031vWqX3Byw2b4UIzkiHoClsmsecIJpZTXB8qPirEwh1CyKirkN7y0dCV2dTKqG/q3xtok4A4cWMXGpkTlkXBeisymrPJ7qmb49PdpJtgtKiKZ38HadTMinXG74P0PFg99sNLDajZQgfBGxBgQNnTkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA39owywC4Zl5Dp6jh+54ZkLkSt90w5VoZMien4DE6A=;
 b=WDUVmxPRBR87gr7lmgxYba9d4D+i2h52BseV+hK/t07Q+tx+9gWbdSnUtjfgYanUEiiC9K5aHhix/snAuNB9ugRmDHjLLK00BXcUkp6IUlJSXshowzht0e0BEle5mT7jlTxS09LmQOVMFox1F2jeThUTdywTp04b87bmltA9q2s=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 07:46:38 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:46:38 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for uniras
Thread-Topic: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for
 uniras
Thread-Index: AQHc+IqgS2G7SpfM70K5D/APWFzt/bY3YuEQ
Date: Wed, 10 Jun 2026 07:46:37 +0000
Message-ID: <BN9PR12MB530618F8BFC465F727B86624FC1A2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260610033823.613644-1-cesun102@amd.com>
In-Reply-To: <20260610033823.613644-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-10T07:23:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|MN2PR12MB4126:EE_
x-ms-office365-filtering-correlation-id: 49f6b56a-65a5-4289-6c3a-08dec6c46743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: VBfnp2VjrAqZehq7BedVI50iA/JBXI/TZf4DXqOWT2eflOGJNcysBADuIY7UcC7NzJpvFH75yZz2cXURGRZ18Cs4CGh82WoGKbwiwFY4x0dzqMQZxOLlWWwc+2I7kfTiYCVutvAeKPXQPC45v045Y9t3lhhi5KZU1VWqbUogMiSeymjCEE4/v/cyTjdNWf7k0p1naefjIcNuq68ZB3NitoBvvN13MlGWcX1bmwKNGZUgQNH64+xEZC5WRN8AG1vkfN9PjIDktXC9tQZhEKZBFX9NDDlLRfRV1YmBkamDpiWXxTE5ZBYgtvWYL1w1cdc4v/7eoqWW0f8EwYoMAKdpwPaC2hLDc8irm8fGE0IPhoLz+j7Qhqoz/vRRS9/OSfrC4uX1cj8p1Q8bhP78LdREFnyR2okN2CXBFE8w1R6iKbV/jXCkaOTw/ejYulF1n9GHNGhpRtugetN8Jl8yDTioNj66/L2p5qBm4AyBPPH6cFgEA4LGHgsbQV357UIuH1pdotMa+/FZE6oGCbY4nlRkxArKU/lM0Rn5aqbdg6OR72bSU5Vvzo5W9lbKQOTpJfMyUf3dKuMiBAUazXJ8x6aL2ZcHc1LI/eqpx70HGI5smZ7BIeOkIESR7TdNV9qfSiVDVIRip52Qk+/ruJDGoUwZUMm9TuY+cZ6y1SDkGEpkFmNta/dEfkNxwQO4FEIkpxPplrkkQz2svx4clLyf1nEqQNiKxd7S3AYXR7U8Z1TL/kYxc+dr/dN/R2OQKVcaGNBN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZGNKUWN2cG9vRzZWUDRHaEczN2Y5OXJPbW9nN0V3NFhjQXJvL216RzVw?=
 =?iso-2022-jp?B?aU9tYlcrZTZrbDRTNXJoOG9abHdDVFRqZWdQMjA4RjJmdzF5cEsxY3ZY?=
 =?iso-2022-jp?B?NUlkWXBpRWhDREkwaUhJSVdFSlhUNDJRZFZiUGVsSVF6eHJVaWNUZWM2?=
 =?iso-2022-jp?B?WVBkNE92dFhzakZTZm1BYlljZjJNUjdMLysvdDRGaFBKVUdpYk9wMWtV?=
 =?iso-2022-jp?B?YzJmd05WT25sQW56SmFDa2NsZHBOQ1h0MkZIZWZoU0x2ZlJWcFpqV2Rx?=
 =?iso-2022-jp?B?Nnd4MDB5OU4yaUJFa0d0R2hMa29iZ21JWUR2eTA4U3RpOGx2VXBaYTQ2?=
 =?iso-2022-jp?B?Y2xCN0hFV1RHL1U5UGlDWVhtK3JoK2MrVm85bHNNTjJOK2hHQmNkMVZ0?=
 =?iso-2022-jp?B?M0xBc2wwUk9yNUM3TE1XZ0M5MTlCZkRmdjF3dzlHQ0lnVGRWU0RVcnEr?=
 =?iso-2022-jp?B?bmFNQlEybURrWTVIT3k3Mk8zbUpCdnorZ3lvREZzdGdsUDJ1a2UvUnhW?=
 =?iso-2022-jp?B?c1lCR0tvcXhqQ0JBKzVXNDJrSStJdFk2VGtqS1R6MkFJTmR1QVE0WUY3?=
 =?iso-2022-jp?B?cUV0VWV2eVpzY1JnRmxpK2xUN2dTZ252WjZWKzVEM2lCNkVvWFFqNXJw?=
 =?iso-2022-jp?B?b3Z0cXlhSHBWS3lsZDAwZXU3dzh1bjFPMVhVcldMa0pEOUc1STBiNWo5?=
 =?iso-2022-jp?B?b2RVczZmOS8yK2lVSHIzVGcrQ3NBSGY1N3laU1dTd1Q0UThsVDJIU1pp?=
 =?iso-2022-jp?B?aDdqN05YYS9JRHVNOTFQaS9tTkdMdVNCZnBuaHM2QngwWkh6YXBsMmgx?=
 =?iso-2022-jp?B?UWFhMVpXV2wyWG9SNW8xNkhMQzVpRTB2azlnbVhNdVhGOHVNQUxLSHhp?=
 =?iso-2022-jp?B?dFZKQ3J4bmdiM1JMcGx1NVdvTUpqRDNrNGNrT3ZOOTZKdHB2Z2R3M1Vj?=
 =?iso-2022-jp?B?amZsOXlORkxhR3grd2lTbGtTNnlEYUNsRTFFSjFueEZzYUtZbW1sU05u?=
 =?iso-2022-jp?B?Q2dZOHFGZDB0T2FKTTIrZ2d0M0FlTkVORDQ4ZEdyN0VaSTQ5LzNvMGV0?=
 =?iso-2022-jp?B?RjJrYnNNdFZ1VTRGT1g3dEo2dkllTWRiU3NHSm5NWFB6emRuUStxeUFP?=
 =?iso-2022-jp?B?dHV0L1JjMEhvQzlBbFluTktDRDNaSlBmR0t2dmh4TElwRFdxMzlMclcx?=
 =?iso-2022-jp?B?Nm1CNTlNR2RGbjRBcVQ4R0ZSQTk2MlFveUYyeXhXRGJZdytCZm01Q1di?=
 =?iso-2022-jp?B?M1AxY2FiNXo1QXpEYUdObnhLQWNmL3UwMTJWT1R6SUxIYzZqTEJNdVRE?=
 =?iso-2022-jp?B?ckxBNlFxVXpFOE5LUXg0bmZrajc0NjJQOUNQb1RmZDd0YlQ2WVlpVUhO?=
 =?iso-2022-jp?B?cHR1dHArMEh6UkcrOTc3bjJIM0ZJcWh2aVpTVlg5aExVOHBZQmZpQlpr?=
 =?iso-2022-jp?B?VzZhVzFWc2Mrb1A5VGl5cmJUVGhMenlicjB1ODhUbXhoSWJlczc3UFJU?=
 =?iso-2022-jp?B?L2RBRVh3SlRqRWlmNk03Vjh0VE0ya29Oa3lYNldobkJMTEJhOGlybW55?=
 =?iso-2022-jp?B?Z1g2RU1YRjlkZTdGVFM3elhsUVpOT0dCNHVBU2Y0RWt1amJhVHRBM2hs?=
 =?iso-2022-jp?B?ZERmZDh3MDEzY1hPRkZObWxlS3BEZStkTjBmUjFDSkNVSGlhWnRXUTVn?=
 =?iso-2022-jp?B?Z2tqdjdwaS92YmxWMFUvUFlxRnF6SVF5ZEFXelJERTZ0ZERONHF4bTlu?=
 =?iso-2022-jp?B?bEJCendjaDUzdkRLcW51VEk0SWxqMW03bTVrd1dlM2YrSCtRRjlKWGxG?=
 =?iso-2022-jp?B?S1d2clU1ekphMS9xdTR4Z1M1elc1U0NqUTBVVjFiVUVWVTVNL25YcVVh?=
 =?iso-2022-jp?B?T0pJVzVMWXRXY1hBdjlKRHU3WkNzRVZwMGpWbTBaNWNYTVpZVHlKSGhN?=
 =?iso-2022-jp?B?RklPd1BrUDZtQlROT0E2cmpua2JCWnZSVFpFSDNFcGYyN0d0RjU3Q3hW?=
 =?iso-2022-jp?B?QU5DNGpnVFRZV29vN2I5S3JlbkR0UnFDSEkxcEZJaitzdTloR1NmbHA2?=
 =?iso-2022-jp?B?aXVJalJ5d1REQmxva0I0STFXM0tBYzZYRC8yb09hVFQxbk9wKzNVc2Yz?=
 =?iso-2022-jp?B?YXNlTU5mMWZvNEN5TzYzN3FXaXZ2ODNSc3NFY284d0hrd0FXVTZlYWw3?=
 =?iso-2022-jp?B?THo3ZUFpanlNMExlcHYzSmVEWkJ0RDZPN2xrR292NnVoN0t0bTdacUJh?=
 =?iso-2022-jp?B?VFZVQTJ4MkwrcWY1SzJYSm8wZ2xna1dnL2tzVThLUC9qWFcrUXM4ZS90?=
 =?iso-2022-jp?B?ME9FMHFkMWlsMGpOU2dYZDE3Q1FCWjZsSi9ucCtaR2J1UjB0UlV1THZx?=
 =?iso-2022-jp?B?bzJjS0lxUnVZZjdoMGk3bHduZC9PYXEvbDVnVW5iZDFrNERKYkZYWjZ4?=
 =?iso-2022-jp?B?c1VWM1BieE1ub2lFMlhKN3l4QzY4Y0pHSjdYNVBVaEpSL015eW1MYVBP?=
 =?iso-2022-jp?B?SkloalRy?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f6b56a-65a5-4289-6c3a-08dec6c46743
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 07:46:38.1411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gI5PAGtiWgcpVpVjMJsCxmQO39c8EWLpL055gFQzqsHJfZ2RwLW4UixShBwMgGaQ6c5KrL8MqhhN7iGZbWONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

AMD General

Best Regards,
Thomas
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, June 10, 2026 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for uniras

Add check_bad_page_unlock() to ras_sys_func and racore to support uniras ba=
d page validation

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 ---  .../gpu/drm/amd/ra=
s/ras_mgr/amdgpu_ras_sys.c  | 19 ++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 +++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 26 +++++++++++++++----
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++-
 8 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index cb6498c30834..473b387fa3db 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -30,9 +30,6 @@
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_virt_ras_cmd.h"

-/* inject address is 52 bits */
-#define        RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
-
 #define AMDGPU_RAS_TYPE_RASCORE  0x1
 #define AMDGPU_RAS_TYPE_AMDGPU   0x2
 #define AMDGPU_RAS_TYPE_VF       0x3
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 7d728e523604..cc6d571a5479 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -266,6 +266,24 @@ static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_=
context *ras_core,

        return 0;
 }
+static int amdgpu_ras_sys_check_bad_page_unlock(struct ras_core_context *r=
as_core,
+                                               uint64_t addr)


=1B$B!Z=1B(BThomas=1B$B![=1B(BSuggest renaming xxx_check_bad_page_unlock =
=1B$B"*=1B(B xxx_check_address_sanity for clarity.  same applies below.

+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       uint64_t pfn =3D addr >> AMDGPU_GPU_PAGE_SHIFT;
+
+       if ((addr >=3D adev->gmc.mc_vram_size &&
+           adev->gmc.mc_vram_size) ||
+           (addr >=3D RAS_UMC_INJECT_ADDR_LIMIT))

[Thomas]  Different UMC IPs may have different address ranges, so this chec=
k should ideally be moved into the corresponding UMC IP file.

+               return -EINVAL;
+
+       if (pfn >=3D (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT)) {
+               RAS_DEV_WARN(ras_core->dev, "Recorded address out of range:=
 0x%llx!\n", addr);
+               return -EINVAL;
+       }
+
+       return 0;
+}

 const struct ras_sys_func amdgpu_ras_sys_fn =3D {
        .ras_notifier =3D amdgpu_ras_sys_event_notifier, @@ -277,4 +295,5 @=
@ const struct ras_sys_func amdgpu_ras_sys_fn =3D {
        .detect_ras_interrupt =3D amdgpu_ras_sys_detect_ras_interrupt,
        .get_gpu_mem =3D amdgpu_ras_sys_get_gpu_mem,
        .put_gpu_mem =3D amdgpu_ras_sys_put_gpu_mem,
+       .check_bad_page_unlock =3D amdgpu_ras_sys_check_bad_page_unlock,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/am=
d/ras/ras_mgr/ras_sys.h
index 8156531a7b63..239e56732e3e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -30,6 +30,9 @@
 #include <linux/mempool.h>
 #include "amdgpu.h"

+/* inject address is 52 bits */
+#define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
+
 #define RAS_DEV_ERR(device, fmt, ...)                                     =
          \
        do {                                                               =
       \
                if (device)                                                =
             \
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 6449d7b8627d..6c3697de1f98 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -231,6 +231,7 @@ struct ras_sys_func {
                enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
        int (*put_gpu_mem)(struct ras_core_context *ras_core,
                enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+       int (*check_bad_page_unlock)(struct ras_core_context *ras_core,
+uint64_t addr);
 };

 struct ras_ecc_count {
@@ -399,4 +400,5 @@ int ras_core_get_device_system_info(struct ras_core_con=
text *ras_core,
                struct device_system_info *dev_info);  int ras_core_convert=
_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
                uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
+int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core,
+uint64_t addr);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 29b1b8f0cc26..efd4023f133b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -676,3 +676,13 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ra=
s_core_context *ras_core,

        return count;
 }
+
+int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core,
+               uint64_t addr)
+{
+       if (ras_core && ras_core->sys_fn &&
+               ras_core->sys_fn->check_bad_page_unlock)
+               return ras_core->sys_fn->check_bad_page_unlock(ras_core, ad=
dr);
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.c
index d4072350f48f..7ff019a8c7a8 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -373,7 +373,7 @@ static int ras_umc_update_eeprom_ram_data(struct ras_co=
re_context *ras_core,
        struct ras_umc *ras_umc =3D &ras_core->ras_umc;
        struct eeprom_store_record *data =3D &ras_umc->umc_err_data.ram_dat=
a;
        uint64_t page_pfn[16];
-       int count =3D 0, j;
+       int count =3D 0, i, j;

        if (!data->space_left &&
                ras_umc_realloc_err_data_space(ras_core, data, 256)) { @@ -=
385,6 +385,18 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_=
context *ras_core,
                                        bps, bps->cur_nps, page_pfn, ARRAY_=
SIZE(page_pfn));
        if (count > 0) {
                for (j =3D 0; j < count; j++) {
+                       if (ras_core_check_bad_page_unlock(ras_core,
+                               page_pfn[j] << AMDGPU_GPU_PAGE_SHIFT)) {
+
+                               for (i =3D 0; i < data->count; i++)
+                                       if (page_pfn[j] =3D=3D data->bps[i]=
.cur_nps_retired_row_pfn)
+                                               break;
+                               data->bps[data->count].cur_nps_retired_row_=
pfn =3D U64_MAX;
+                               data->count++;
+                               data->space_left--;
+                               continue;
+                       }
+

=1B$B!Z=1B(BThomas=1B$B![=1B(BAs we discussed offline, let's see if this ca=
n be further optimized.

                        bps->cur_nps_retired_row_pfn =3D page_pfn[j];
                        memcpy(&data->bps[data->count], bps, sizeof(*data->=
bps));
                        data->count++;
@@ -489,9 +501,11 @@ static int ras_umc_save_bad_pages(struct ras_core_cont=
ext *ras_core)  {
        struct ras_umc *ras_umc =3D &ras_core->ras_umc;
        struct eeprom_store_record *data =3D &ras_umc->umc_err_data.rom_dat=
a;
-       uint32_t eeprom_record_num;
+       struct eeprom_store_record *ram_data =3D &ras_umc->umc_err_data.ram=
_data;
+       uint32_t eeprom_record_num, logical_count =3D 0;
+       uint32_t retire_unit =3D ras_core->ras_umc.retire_unit;
        int save_count;
-       int ret =3D 0;
+       int ret =3D 0, i;

        if (!data->bps)
                return 0;
@@ -515,8 +529,10 @@ static int ras_umc_save_bad_pages(struct ras_core_cont=
ext *ras_core)
                        ret =3D -EIO;
                        goto exit;
                }
-
-               RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table=
.\n", save_count);
+               for (i =3D ram_data->count - retire_unit; i < ram_data->cou=
nt; i++)
+                       if (ram_data->bps[i].cur_nps_retired_row_pfn !=3D U=
64_MAX)
+                               logical_count++;
+               RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table=
.\n",
+logical_count);
=1B$B!Z=1B(BThomas=1B$B![=1B(BAs we discussed offline, let's see if this ca=
n be further optimized.
        }

 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.h
index 1d3026be509b..05edacc165ba 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -139,6 +139,7 @@ struct ras_umc {
        u32 pending_ecc_count;
        /* number of entries dropped because pending_ecc_list was full */
        u32 pending_ecc_dropped;
+       u32 retire_unit;
 };

 /*
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..0064e89ac1ab 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -110,6 +110,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_cont=
ext *ras_core,
                        "Unknown HBM type, set RAS retire flip bits to the =
value in NPS1 mode.\n");
                break;
        }
+       ras_core->ras_umc.retire_unit =3D 0x1 << flip_bits->bit_num;
 }

 static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_cor=
e, @@ -166,7 +167,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core=
_context *ras_core,

        idx =3D 0;
        row =3D 0;
-       retire_unit =3D 0x1 << flip_bits.bit_num;
+       retire_unit =3D ras_core->ras_umc.retire_unit;
        /* loop for all possibilities of retire bits */
        for (column =3D 0; column < retire_unit; column++) {
                soc_pa =3D row_pa;
--
2.34.1

