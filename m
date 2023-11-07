Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD139C4167D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 10:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A8A10E144;
	Tue,  7 Nov 2023 10:47:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5F810E144
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 10:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQjHpknZmp6mQFkiEZZ2gjQZzFvRz3ZcFArhEONMhk8kdaMdKLEJhC8eS6jFBalE/7LlsZjW0RSpZ61R2glIUvWewJr2wVXFtwQVl1Vpe1Vytk0KSMcD3MJQX43MEtvwbYktAeaYeNvuYa3xmm7acUU3eslCO7xiql+2gEquHPMsQjXGBJ+gcRIKNk/DeTNvCvZUuUOu6MmzXXCrcKN5Ze4PixOyq6H/8a4f1CAY6B/4bsnCbosqdRuhCDICmfct8mvDe8Toy3Dd1m8TZlY1pfbUfFrq6mdrGPYZVINYwTCPnBQiF3BnMHcEHWGb3EgoQRD5jfiaPz8W7MB9l0s25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x/XkGxfeGo85+CxNrtM/wL3q0el5jxkeL8vgioIJ0k=;
 b=LDqAOC9r/nLgI80wTM9k0wwljjfAIUSg8w/uaqHuo1Gs3LHLhMf0h2sEUmtoNun3Lj2gJ12uQw3BuVtqpNnRH0F7Mz1brk2bYEbZpSrdeNpNRhVmvgRzVIKmoHHkF7P2HUOm0wb2G/HxTyLjoqLey6dPbLxg5QohV1WI6RwF5ogLdGYlaDVwyINTVR5wpnYNH5jwXVjTjh1r+ec7Cj/OYKBBK1vD4f7WxQYqTYRzPPzQwz2wtGzSUb5xMPN6SLWWAl2xFBya/4+4fH10TxZSr+wwisEd5x8sLVGWxyalxQ/LsONpeXCWm17k0gHZJ1fhayMRFCZEqm0VVCMPzdbbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x/XkGxfeGo85+CxNrtM/wL3q0el5jxkeL8vgioIJ0k=;
 b=LF04hzP0gVv6EJJlNZ4oDtmnt08M+AZWhKoy3j3ELt46ttH0CAa1is0GQImOtUENcuIxH8zn2QxXBwxgOLAQ2Eivztnh9BhVBzlry2RgRVCK2pBii/bZvqnyUDucuzfvnNMsvGZrR1Yi2M6x80GxuL3kemS8OvcUs8CuAnnmY6k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 10:47:02 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 10:47:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amd/pm: raise the deep sleep clock threshold for
 smu 13.0.6
Thread-Topic: [PATCH 1/1] drm/amd/pm: raise the deep sleep clock threshold for
 smu 13.0.6
Thread-Index: AQHaEWX/p6oIhbvIA0y7OHZs2abNPLBurJhA
Date: Tue, 7 Nov 2023 10:47:01 +0000
Message-ID: <PH7PR12MB5997CF9ACFA0A4F327CE067082A9A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231107103410.11435-1-le.ma@amd.com>
In-Reply-To: <20231107103410.11435-1-le.ma@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46c26ff0-48b3-4e78-9fe3-69b439d61795;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T10:46:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS7PR12MB5767:EE_
x-ms-office365-filtering-correlation-id: 177fd47a-4359-4509-d669-08dbdf7edfcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZtM4hExn/7aRsSkHgczP5F17woB0Mh7jJet97FB3XPy4TNzfDInXEXEoZsXNURdfIgkIhHAYrB7M6kv5gcwl9EtdcMz20tyPMUGxu2oS60f7TeyTXIK7zsWEodMCls5sQ3rBx6sZIdgR9ZfUp8tE5Twzg07BxWBGXy+rF5NL6k1dUiyT1JbYB6M4QVpEFnW8htUxc+WvkmhqRGNEbUkj3EhrZ8VMiApK+2TQDEPzmB/G0+X/QRJBT8CqL2PPSruNi322wDReNnFKfYJ38qFhmmC0qFmdWhPYN3yoQSMucVUr4AvX4i3D2h3truVIAGVoCmTkeC/f94OXdNhWB4dyOLGxPYZszcZ3vagDKzmkCpVHhHveH9Ep/AhtQYKlpJjXNaydLqx/jgvwOlSPQAsRr0vJofxVa76JxShwYsE0cgZoDFroiw7UZQduBruo4UwMALR338mKFBVfQhUgzvRXLNZGqjQpPyzwXPXt91Uwo98RSGiUNsZ4HBmu7BEsayTHmE4hCb9OTx8rQx+kbjW4qAY7hfwekPBW/n/rSDtkeryCAXsiuNojEHEeRG2W3P6O0te3qcY+wEZkoUmQsfjl7diD/jclHEmCzMxaGpEARQA93WLeuDquHdosBp8UUAh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(9686003)(71200400001)(6506007)(7696005)(478600001)(53546011)(38100700002)(33656002)(86362001)(122000001)(5660300002)(76116006)(66556008)(66446008)(66476007)(66946007)(64756008)(83380400001)(2906002)(41300700001)(26005)(38070700009)(110136005)(52536014)(316002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1YMzK9QWj3clUHcJ6L6+y9OUGEF+dtfqsfYJNtlNLXfVuDruiGr28aZQ+tAo?=
 =?us-ascii?Q?kPnaoSt9dR5+p5g35+p12u7Uyv3MaEqvjowCzRXOol09uAXyffhd6/yRXFkU?=
 =?us-ascii?Q?zx0XeCQkA+/XRaudc7s7umB0TCBDQlFpzvhXvB+7UABPEMgRXnDOf2yhc9LP?=
 =?us-ascii?Q?OaLJ4GVbkwoYTBCISYzm0W2E8NQSyjzub3GI/UeS1jweE6DUMeb8jyXIB4K0?=
 =?us-ascii?Q?QSsCGa0jKMhr4kM4O09szm3dEuUIYcmtlSt0/cc9uJeKn3jXudT/5ZovVeyf?=
 =?us-ascii?Q?9uwtuKqj5Qg5yr7jGsPsRer2RcMcz2ALD477nx2zFVPwPJnrZ7vHXvERPZ22?=
 =?us-ascii?Q?SXGibqz5/1FEuTNi4I+jh1n2uLDZegifWRHJa3Fq7oifyxo1MfrzFk2X4Va0?=
 =?us-ascii?Q?5eU07jhX+o76Ehwizd5nU2jNASi2uE+rf9bFD6t7C/VqASQLJDYj2znVVWjW?=
 =?us-ascii?Q?wV5t82xEYXbKI3Q793ickf9/4rTY931/gSkEWpN2uJqo4r4G+V0xWIGF5Zjm?=
 =?us-ascii?Q?bp1wMB2H81EGJ9C0zUQqHzyLnD2nuv4RBmc7B2Dqaya/VO/hu4F28/4xbRy+?=
 =?us-ascii?Q?5nIQBqxT2dLxTNNLqneQEPRd0n9F/ocejxJqFMfwn1e5M7LnY6KKaSEEQZMx?=
 =?us-ascii?Q?+5E6FY8LTZHaKX6cY1CCeie6r5eSSY4LsRYm9By0yHDhMBsPhyfpPa5iFmPO?=
 =?us-ascii?Q?F54sdn3EOfOgapMinhu5pGSPFinQhVAFJB4oleh8c+vbeUhNGPLMjiue6/15?=
 =?us-ascii?Q?PFvDCTUD/4VfoerA7NXWA6ty/Wlf3+9x6cXCx+q6JXsNDh11Od/ZGuDz1F3p?=
 =?us-ascii?Q?W778bOxqwDI3ILkkQKaEYpiNe3mmU4CVJIVy1mKQCjAe8bJnatBX772VyO7x?=
 =?us-ascii?Q?ong4XUARqBG3+wkv36aaw4AI+6Ho5XXWH3b6K4uPYYnOs98oMY6nptvbvadP?=
 =?us-ascii?Q?vUI14WF+pW3lXtfxrxId1+yUfPiPVM1WhxwlUZ7OGgDt88xxrMYBegUAyWII?=
 =?us-ascii?Q?TgjLNK8NpRugdTY/B2b7D1fSoqwBX1duZsenYXz6JBtXHzHdnm54eSEdy0nu?=
 =?us-ascii?Q?4TRds9HVnCpG0XIrWS0BQpkQO0Gf3rxuhtBO5jFq78nlEKRfCLcGytcVl+XS?=
 =?us-ascii?Q?9u0+4AAhoSMsCs5BHBX8luAuCHtrdMRT7mvprtxxFaq4GrB6gv3Y4hkSPNIu?=
 =?us-ascii?Q?HOPEK/hoYLE/ILthJnknxPfkggOcEZpIE9I13tL1+hrKaMp8ccESjzljZkQk?=
 =?us-ascii?Q?TnF0hVEubiqrsvrNaPr1vkFYxaCvUdpw9BhnUe4HANFKX9b35VXpsq7ei+ma?=
 =?us-ascii?Q?W4Q65AoRPxd78uW7ctOxUCmtgapwWS7cuTgOrAwAOoycBrMBB5Wih/Ka53lE?=
 =?us-ascii?Q?NjYZOnQpbNJUq5p5gSAwCI8CZzvCjMPof0+qUruU4iypheN4dyMb+SmXlvGg?=
 =?us-ascii?Q?03b8Bq8WMDX+mAhMJOcWcGyvq//M+mhTghaOaDVClyrn4x+fdI9I6yMspTvP?=
 =?us-ascii?Q?Iu79S13QKsH31rMq3k+GkLZLWLBcmlIor5IuZgHfxm2+SzZum38Gr6+x/YDm?=
 =?us-ascii?Q?yQS+B3oN9gBKQML9L4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177fd47a-4359-4509-d669-08dbdf7edfcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 10:47:01.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0QpSPFcufBaiOB555ggR2H3y7j5Z41UUbvnk5u4U35VMDYLdIS54JJU7Xja3Pq0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Le Ma
Sent: Tuesday, November 7, 2023 6:34 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd/pm: raise the deep sleep clock threshold for s=
mu 13.0.6

The DS clock may exceed the limit as sclk dfll divider is 16 to target freq=
.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 20f66e696f87..83e1228e6eee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -94,7 +94,7 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX                         4

-#define SMU_13_0_6_DSCLK_THRESHOLD 100
+#define SMU_13_0_6_DSCLK_THRESHOLD 140

 #define MCA_BANK_IPID(_ip, _hwid, _type) \
        [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, }
--
2.38.1

