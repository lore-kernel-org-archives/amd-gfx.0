Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC13C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE8C10E61F;
	Tue,  1 Mar 2022 16:26:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927CE10E61F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9VdOcjF1XKdE/e9bprGlH1achZbJF5WpAY7nqIfTEwY3nDS/3/FZSyGdvNyEnoUGrjFELRELSUKIuUUsALWW13hkP0xBPOMqqiGiUuhEToTqJuDs/E0/0WeYQwBTZY5Qn7uOtzaUP43iFxJt0gF022jHho2GdflVTY/J4zsybuYY/lAd+nSjFlcpEzjnACbM6+UiZIJiIO+UE3s0iy+LHXpIh0/9Rz7cmUAmGCa73uCUaYYm9ucnEWyGYF1VTDlkXMZwDwYZah1HomXklwskEA2aheU/9XWkghiURR1VcpjlKMeSSntcSuHjBfBlaJBHOoTmCp2EDp+Q53IMcRd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaArx3DFzravUgLSoljmB4b4sWGHPl4zgs5oK60fLNQ=;
 b=VXznCaIRu3oU8oX56jbuDmr/olKRNMwKjU9IMSeWb8gwHCC2j4qWO3Y5dXCnQvJhrJ1wM/oUqEho/ToHZLi4y0D5ozft13kAR/sCvY/5BMa0LLq5w2on8PRrOJu6o0sL/E9nVo/z2EqnMKoK50s9+jnN6j3Oa8BCJdBqw4tIUySoU8ittk8QkWVWKhOuRnAcE/SmLedOzS7SUNc7P8M3PszQhcKyuOmdS0NEU5xlud2yeXEA1pRvmJ/TRcf+uWvyqYfXypF67YqIufCZJk61bl7nxTQhxPS2wVC1/C6Nvrst+0q+P8wv4+n0AO9qWW7IQwPvjfQ9P3HDiz56N2m8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaArx3DFzravUgLSoljmB4b4sWGHPl4zgs5oK60fLNQ=;
 b=PgXY/T6jr+p7P3b0ay62YMqGgsJUhyiqvE90wx1C8xHLx8KN3Uj2F+K7bq0OZcTOSG6mvi/fZwsF/U1xTD2Z50goYBWz93vvB7Tf+I3e/Q0EFre+HxngS7q2zuaK5OPMjiIbt23IJncLenOHCQMTtMObtvDuDG2ojyy8/lzHQl8=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 16:26:09 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::eca0:b18a:8594:a0bd]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::eca0:b18a:8594:a0bd%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 16:26:09 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Move CAP firmware loading to the beginning of
 PSP firmware list
Thread-Topic: [PATCH] drm/amdgpu: Move CAP firmware loading to the beginning
 of PSP firmware list
Thread-Index: AQHYLTzQw9NGUjLyckCFUTkjWHTUrKyqt30w
Date: Tue, 1 Mar 2022 16:26:09 +0000
Message-ID: <MN2PR12MB29579A574A0FAD048EA59E29F4029@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20220301071914.1624490-1-Yifan.Zha@amd.com>
In-Reply-To: <20220301071914.1624490-1-Yifan.Zha@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-01T16:26:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c44b9ffb-9000-4971-95e8-f84d91d798c2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-01T16:26:07Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 22b7a6fd-1827-4d78-b98e-8501fce0dfbf
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ca910f-f147-43f4-5670-08d9fba03199
x-ms-traffictypediagnostic: SA0PR12MB4448:EE_
x-microsoft-antispam-prvs: <SA0PR12MB444815F668BC629ADF3AD418F4029@SA0PR12MB4448.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiCGNob4N7ZGbd292rIl3L33xH4kTwmRlBlIeSZMMFZhXOKBiP5By9MBXfMTBQUCVgfM9NLeCpcp04Ay52H+BEZFXFQ0ZrM27iZDkXlZHZv4S0JrTCB3kQpZPeWyunkGrpNXIfEdlZP6LDu04guCnmtiuIUDpnhUS56tZuGlBzDAglX2vM9z6oyZWYJ/yeHqWX1OOqgBktIE0vsZtL5vMa/YVJmQai9DLjdVrPL2SzFrG4IbqagLdgI6erg/NqzHJJiJb9GWM+VxyIAZ7Zwu0PI0lBTjDY4GpSDGYwwZc27lYkm/fWmk34VOJ0/9HXgg6F3G2+OqLDWn8egK6pRrQtjEMJP8SPW8Xlony9juLv6iZvfsu/qEULdDYkV1N5a3zI5doNweMS1J6BZ5F21DxIS+ONHLBnJzGnhSpD8CeBfwGihTgDXvLFRMKHpabodj6Q3NeHkg9nYolB0kGrIpQNfaO1Q1hLmapUoCTGsM3nohHe5YNHklPGUUZPFj24koXTrm4JonJuGwOWkp8Bg/dosjYNjIL+CZAXHHOtk11AVw/BoOFampt8s0a/aepRdVqsMwqda39dKq2kdEoHKWJ34I0vI0ACYQCJs31Cpne0jdGqzbIo9cyLtmzc1RauTnlhuYfBC1j20pd1PbyePjHEPISkwXdlBmc25Oc+d/LlCxFWNivhd+BXizPi18sLB2L6FuMhMgUVbyAUJ9K41/sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(38100700002)(64756008)(66476007)(66446008)(86362001)(66556008)(8676002)(76116006)(6506007)(7696005)(9686003)(66946007)(53546011)(508600001)(38070700005)(122000001)(54906003)(110136005)(52536014)(316002)(8936002)(4326008)(55016003)(5660300002)(83380400001)(2906002)(26005)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VqhoH2fnVYUdOVsZnfvE2Ucq7h/tU/d8KKUGBqroPf/FMcSk29eS5PbIC18T?=
 =?us-ascii?Q?YBGdZUSeDc6/4xZI/7BnYqMvnRDUHG5iz24Rd+7o54UO/hPCaCnJ18MchTBH?=
 =?us-ascii?Q?vvQOx0pTOCNxEPcrmeEHakqanDFUmTkV7nbHOUg4RXCsW2MSGDUZo6JjnEhN?=
 =?us-ascii?Q?rc//fnEUhcSyprL3/Liq81wo5PpKYglfSxSuAn+wvpX75mZYqnSWMABQukC4?=
 =?us-ascii?Q?5DftE3msn9CBnRgQ19dMUDisBJG6WJb2TxyhN5ty+HUSLHXKuVCTw3X+KAUb?=
 =?us-ascii?Q?8G7dkCvZBSqOh+6aSEY7+UWCaEK/OfUuuitZDiTRVreN4nDfqgd5PD59T+zB?=
 =?us-ascii?Q?9UEss9TawtXmj1sMqUY7ehbqMLMlGfYtZza940FbgKYRhSO3IOkRULymg4VS?=
 =?us-ascii?Q?xb9r8SZk6d9kKjZatL24DhASWsoTT2bqANc+zygoIv7XHIbOFtyqowDbq/XO?=
 =?us-ascii?Q?9Clt8lpOXLrKmPYNmbGFvjY8+awmfVqBYYDoSLcS2auu3sgpSkciRzY0I23U?=
 =?us-ascii?Q?cdfX4jqBOTFyKOVlI7uBb5dtJ/LES0b5ZGHNqaj9rNS8RR9oEHT4GoOCspXe?=
 =?us-ascii?Q?45jBTYItKVM6Pfmi8taIj55ByO1XrKoWle1OeHinsmHoMwNLART9Vp5ILx5y?=
 =?us-ascii?Q?q5qZUNKq+U5LBFnVBZ/Ygnipn0ecSSXKmxvD3l/5/Gh/fFC9rBPVuEm8oebC?=
 =?us-ascii?Q?6t8dzEtUZm7g8Fl5qwxBM72la+Ar1wqcZ2Vm/zQbkyi87d+uGfVaSyWbKGKM?=
 =?us-ascii?Q?qcAHs3Ua+Pd1C1sFa22zVoavSSwXrPy2iq2cIa7uB5pg4VUioBQDIy50+za8?=
 =?us-ascii?Q?7WWfkX0ao8HHe/gnXbe9vfC5Bu/JYBxdFGONe4wAFXB9YHCwt1yb0H5Go8oI?=
 =?us-ascii?Q?jwZOO2Kvm0CZ6URp7AGgcjY3tCuxO2Ciw9fu+xRcUxceJeLZeGvfA3hTjkmu?=
 =?us-ascii?Q?06K1w2FIoMxgmqotfrmk5BiGjqPP/6UsZGwMOV1RHjmvw4GHJabXiXBqQBHV?=
 =?us-ascii?Q?3sGrYnXSFxA38qA05XeAgl2BBKQgXfQz9r9/B0U/9iWVmAwmcqU+D10Uwrfi?=
 =?us-ascii?Q?XZ1qsYTYx7fRGvjHx5W3glN1VkNKnRbPi9iy4FE3DUXV9IJXCQKVgmLuCPuC?=
 =?us-ascii?Q?159X5yX2PMDqgZxl+Ou8EuAo1e2Je1PewSafikGBODO7kcZT406WFzH7YiX6?=
 =?us-ascii?Q?mLddFrnjCX1PZC5U2BLELsMMSUzliQ76IKRG7qaCG27mCE8EKsmhLFgavfY4?=
 =?us-ascii?Q?5MKyK5PZWIxWnKdAqsQTxy+3J6zfl0sLeuyHKRw+hCQFf8eFUzbQcXI5cL4w?=
 =?us-ascii?Q?3AsQJE5zObn8s9wKHSMSAMLoB4LAdYIZp+8YfmjFsX8ZabduZsibcpvzyJy+?=
 =?us-ascii?Q?EpG2tVzjJ8bqi3DULj3s10HgHdBbCss4dIAujbhQquCWWFWS0mU3JIPhWd5E?=
 =?us-ascii?Q?2iO6BQkkHjEhiAwu600aE4nRK/UVpGinfNxgTlFYe2BGSuE6znhbw/XYwboE?=
 =?us-ascii?Q?w4znLQabjSEO4npA+xWEYCXzoM3fUlN7aICZI7str8X2j4ysVsaXisU0QsfR?=
 =?us-ascii?Q?XO9HkREj9/Uzba4ZCuw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca910f-f147-43f4-5670-08d9fba03199
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 16:26:09.3389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfqBbsz61IGpVdfNxzEF2NDdHxq/7Ihwj9F9A0JA+HooUfiGdCQ5hWO+oOiR1G8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chen,
 Jingwen" <Jingwen.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Bokun Zhang <Bokun.Zhang@amd.com>

Thanks!

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>=20
Sent: Tuesday, March 1, 2022 2:19 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Bokun <Bokun.Zhang@amd.com>
Cc: Chen, Jingwen <Jingwen.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Che=
n, Guchun <Guchun.Chen@amd.com>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Move CAP firmware loading to the beginning of =
PSP firmware list

[Why]
As PSP needs to verify the signature, CAP firmware must be loaded first whe=
n PSP loads firmwares.
Otherwise, when DFC feature is enabled, CP firmwares would be loaded failed=
.

[ 1149.160480] [drm] MM table gpu addr =3D 0x800022f000, cpu addr =3D 00000=
000a62afcea.
[ 1149.209874] [drm] failed to load ucode CP_CE(0x8) [ 1149.209878] [drm] p=
sp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007) [=
 1149.215914] [drm] failed to load ucode CP_PFP(0x9) [ 1149.215917] [drm] p=
sp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007) [=
 1149.221941] [drm] failed to load ucode CP_ME(0xA) [ 1149.221944] [drm] ps=
p gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007) [ =
1149.228082] [drm] failed to load ucode CP_MEC1(0xB) [ 1149.228085] [drm] p=
sp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007) [=
 1149.234209] [drm] failed to load ucode CP_MEC2(0xD) [ 1149.234212] [drm] =
psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007) =
[ 1149.242379] [drm] failed to load ucode VCN(0x1C) [ 1149.242382] [drm] ps=
p gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0007)

[How]
Move CAP UCODE ID to the beginning of AMDGPU_UCODE_ID enum list.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 428f4df184d0..40dffbac85a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -343,7 +343,8 @@ union amdgpu_firmware_header {
  * fw loading support
  */
 enum AMDGPU_UCODE_ID {
-	AMDGPU_UCODE_ID_SDMA0 =3D 0,
+	AMDGPU_UCODE_ID_CAP =3D 0,
+	AMDGPU_UCODE_ID_SDMA0,
 	AMDGPU_UCODE_ID_SDMA1,
 	AMDGPU_UCODE_ID_SDMA2,
 	AMDGPU_UCODE_ID_SDMA3,
@@ -378,7 +379,6 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_VCN0_RAM,
 	AMDGPU_UCODE_ID_VCN1_RAM,
 	AMDGPU_UCODE_ID_DMCUB,
-	AMDGPU_UCODE_ID_CAP,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
=20
--
2.25.1
