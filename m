Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84161C761A6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 09:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD7D10E165;
	Mon,  3 Apr 2023 09:38:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501EB10E165
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 09:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQZP4Y2PnfgBY1f4EONdYYceY4eMHDbY+RdcYwHXLcG/C9Evme1rnaHsk4MgX0EKwKXW/feBSUHoZWlWVVjQ/smfuVyc+EKob6ZPokv9FyWraCS5fu1StlewhhKye8l82r0FKeVHsxJ+Y1n1qQnVvDxoPg+b5auYUsDJ+HDIhSBVOkQj1Hj5BzgZjcn03lFB+u7aDbMl6PBeSRlFaO3tnRZ3bkmZSP9AfR5PhQy8FM4CSug6hpefVTmbZ8MyiZp3ryUF9Kc9oAfg4lJWhKezwdzyERoj5RVpfQXRyHFq0p/I4txiwRH9YtuJjHKRQWFOfIw9la3xcW0k+Jn+KmSTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lke6TrZoOdaG6pLOud0ZYLE9UlfDBuOg9jZoDZ3q8M=;
 b=QJLwLzjmHXDFtIsz5bM8H/RqFdzaTU+DnxXBDtK4rIrk3Zs7wPRDdS6ivZLLz/TW04JjMGYZj7/leynpPXCXx1TsfNOGMwpKfXlWPh//RTp67meBX73glhSbkPhOd4/JCXQlL7kmLMIQq4tahkeVxLCLKzP4J3o3hRi84p3dhV8ztu1NsjIibP5zf8ma7ICOHkv+A03lNw5Jo19az6/Y1wp6BKXha6M2zD3K8LgphZEhHwMSUCTdUEF0M+8WOBCq7wuyjSP9WoVP1//i9FBeTjg/7x/xBvThg5SReQ5t0TSA97nh2t6A9Uf+SzOdYMbAgEPCjA+Hp4B4Mx7yYJBT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lke6TrZoOdaG6pLOud0ZYLE9UlfDBuOg9jZoDZ3q8M=;
 b=m2xkPUS+PzzMNgeza/fuQh7nC8FsWzPF+JTVoiYL/THVMYB5Lg5Nn3XTCwOgOZwkcr8hujyiL0k2X5kfzYl5hNkq2C/47U4PTC6aBH1dCQWPxN40OXJvQquLzl6yEhgZN37t4Fp+WnsuLBIq7zMznMcpoJZ8FOsa1DlqQLyq0yg=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 09:38:50 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:38:50 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Add MES KIQ clear to tell RLC that KIQ
 is dequeued
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add MES KIQ clear to tell RLC that
 KIQ is dequeued
Thread-Index: AQHZZf7tr54azhtlmkas7+vCLo9wiK8ZUqMQ
Date: Mon, 3 Apr 2023 09:38:50 +0000
Message-ID: <DM4PR12MB50729655DF44988913E17A05E1929@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230403073527.3479900-1-Yifan.Zha@amd.com>
In-Reply-To: <20230403073527.3479900-1-Yifan.Zha@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3f752869-95d6-4a6a-a94a-b8d868c10d80;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T09:33:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: 6cdceb67-b0f1-4a94-fe48-08db34273b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0rQKDxFBYhHc1Ylb6OFYLiBeLWyOkXuN+ExN8BtU60WHdclEnwv/cdYhdmllxmThtjMK7CP/O294JzmOqVrNbLOUtW8M8YOJNM7SKsbz4R3laESHoJtkYAZRzlAqyaOKi39dUYU9/Y7W6jT9bDVzffvbBWlKheH/FrL2QEBfMo/x5H25Z0JqMaDvxvmGRQimCYknIsqfo1JiNZNgrJ3s5jZlCcFFvu7v8SN7DhrnF9u0CylaidHzVNJ02l6tn7v5kgMlYrRpuHmj/ib/ust70u4EHflyS4Zg50a+FFbzNKVpfpJSBd3+7X+eAGwx24eHcv4CP4RrBeWFTfs+wT04/4BEPUnQpkRI2qfAExuZfuxzQXLn7OSoKRdWga1AhlZAX0Us+eX1/fDdD70rJCJcFPuPh7wscLRwK+50/BjwGWW6NUMwaekLorPUJEGYwy2lCqPqXbOZoCnzYFYktDA73uqHjTzD2c8/eifzbEiKw9Hr98N+fhdWpUHTui/myfba5W03smjeV6Ar9EwY2PXi9FMz8djY4eqeltVc8f7bsrfhhdD7Dr+gtFI5izM0Zm0U/L8MrFfeRX6ZR01LUj6pcObB18qT9nyVfYtLYVlMkQ0IpmE4I7rat67aGRwFDhm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(4326008)(41300700001)(64756008)(66446008)(86362001)(38070700005)(122000001)(38100700002)(53546011)(83380400001)(9686003)(186003)(6506007)(26005)(5660300002)(52536014)(8676002)(8936002)(478600001)(6636002)(316002)(110136005)(66476007)(76116006)(66556008)(66946007)(33656002)(7696005)(2906002)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DFTB+LB1Chq9+ApD8MbSwlw4TLwA7qgQme46BD8a0ErHxvUX9OykkVknoHHc?=
 =?us-ascii?Q?uHeUaX0W9IaV20yG0CJFy9FB3gkBkfS6J6cTphZguoBJmYbP35MUEVijfmUn?=
 =?us-ascii?Q?TQR/RTFMIZdHu3WGHlRuRmWd3LCBq5y9HEKnbo9ImIMum2jY9GlFM5Lile2A?=
 =?us-ascii?Q?IWJIhSWH3GbdLcETf/e5CGT/rmA+pybCYKkpxE9RM9xuioN7pRg1w5SHtxkI?=
 =?us-ascii?Q?anuJarpj7Xk4YAWNGb72cX+NYIHzdnBBumHnh4GFIQydGdDPbyCNyR6l3XGz?=
 =?us-ascii?Q?XSltYcl4nfo+ul74JRwGCSIP75S7vsehthyFTbV93JkYYqKgfPFbdjPFfT0V?=
 =?us-ascii?Q?JX2F6D/mGmratusZxJSfimT7HS0z90oDFDShA+rnte2I7QqQhLv9llN0IbzD?=
 =?us-ascii?Q?EDneiMu+6c6AZx3hfWV9dlOvRs46WPAC1x1GSxaDrihQLm5kbPelN0luNzG5?=
 =?us-ascii?Q?2Y5YXmGLAgKQapz/M2HlCafDoKkXiqjQKUBB3FBpr1AMnW/GlQ6oP68+2i4F?=
 =?us-ascii?Q?hy+GFZP7i77CMSkOBlYQDksET0AUnFSkR9lMX9pCPtnwPKhvmp89zLcgJVPw?=
 =?us-ascii?Q?yfm/bOOdct1EqFPPECpKgFZewkzEJ6cbuIrsUPuC4QWpD9y4EeW35KC0YmEQ?=
 =?us-ascii?Q?H2R4eZxuust22fX51YYJvi0kI+SY1BpFS7u3dpxy8zAz2XNC8Gc9th5c9FAo?=
 =?us-ascii?Q?spFzy3ADmSFyyzdxzglu+MuLDHJ/6etm60eF6B7MeM2254q/wRCWOo8cKNaH?=
 =?us-ascii?Q?HrxdX9819cBbbigiw1kBH5Z7j9lZxf8QlX9UUSIh3AM/xxTmxJH0f+erGEtg?=
 =?us-ascii?Q?LmAulIZ599p5xsHChJK8Sk+E7f7aWz1zyPCmdufXLpXi3/f+9Ewc25UGdugh?=
 =?us-ascii?Q?0cuvDd4zg4/yYU50efQKgekKUi8PF4sIdrBJyhFV7+DPYGDaIQcXkEL7oi/v?=
 =?us-ascii?Q?MJ/PMdMqE+2ZksRiF0p/1hd5KySqPUa3eRjBT97tyrI+tQH5ZhHAOj+G5LJE?=
 =?us-ascii?Q?2YT2vb00pPmxmmQIthbAthnYtZSAw+o4zG7VtQlOPthUzZI95ZteZdUoUfb6?=
 =?us-ascii?Q?kLmudNlKdV5eSwoH5q0W+RCHYhkcaC1EwYxdymVvNAAf0/Bd6qK15oX0BzNa?=
 =?us-ascii?Q?QHfmGIqgcPlDx9NtgDWmyU9ssYTbZiBOY+zCvL1Bflum3+69a32uV2FE1khK?=
 =?us-ascii?Q?9JVCmhoczWee+Wcknh51C6LtqcklHPPCO2gx1Oidn/eremmVY+rKU7fMltlj?=
 =?us-ascii?Q?C4BTU9/hIG0qUk2x5Y6Sqmvc7mbBvRL3P7jeS6UqwrIhpl0cVHJQLDBnW0Tr?=
 =?us-ascii?Q?pEbkpb2QOb1tv8mxOZJHhPWGCpbR77QXGAquNOAvcZk8JCezBelpuvw/CoGD?=
 =?us-ascii?Q?clG5h+qayYDiYXk0KxFTtzrym1NHI4magE9/FJ/eaHz6JaXYq2F47o5ZNctG?=
 =?us-ascii?Q?W2r45tkwkfceyLs4KttEyzSawFHs6W2gvBXWS5VGefgmHb965dsx9xcrHdoy?=
 =?us-ascii?Q?HCLnKNLPe2T8gglaTiZowQUBnGeamNmE8AG9FA2RLYj6UEoqSQW3M+dq1Xnw?=
 =?us-ascii?Q?3h53ZF+sRTDxsVr46xA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdceb67-b0f1-4a94-fe48-08db34273b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:38:50.1915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Psc7miMYtRIKWixoImEKrYcRXBMB7iLlFro/Ez2hHx7clEbIMYzFAuQzu90FwFEa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-By: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Monday, April 3, 2023 3:35 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Chen, Horace <Horace.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
Cc: Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Add MES KIQ clear to tell RLC that KIQ =
is dequeued

[Why]
As MES KIQ is dequeued, tell RLC that KIQ is inactive

[How]
Clear the RLC_CP_SCHEDULERS Active bit which RLC checks KIQ status
In addition, driver can halt MES under SRIOV when unloading driver

v2:
Use scheduler0 mask to clear KIQ portion of RLC_CP_SCHEDULERS

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 4f0166a33732..67f7557d545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1138,6 +1138,16 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring=
 *ring)
        WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
 }

+static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
+{
+       uint32_t tmp;
+
+       /* tell RLC which is KIQ dequeue */
+       tmp =3D RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
+       tmp &=3D ~RLC_CP_SCHEDULERS__scheduler0_MASK;
+       WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+}
+
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 {
        int r =3D 0;
@@ -1182,10 +1192,10 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_devi=
ce *adev)

        if (amdgpu_sriov_vf(adev)) {
                mes_v11_0_kiq_dequeue(&adev->gfx.kiq.ring);
+               mes_v11_0_kiq_clear(adev);
        }

-       if (!amdgpu_sriov_vf(adev))
-               mes_v11_0_enable(adev, false);
+       mes_v11_0_enable(adev, false);

        return 0;
 }
--
2.25.1

