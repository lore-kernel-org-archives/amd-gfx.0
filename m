Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09E4C25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 03:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C1D10E0C7;
	Fri, 10 May 2024 03:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtDmVRtg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E3010E0C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 03:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibPEl26DJQRR4HZRwtN59ECogIz2Hq/gjicwkXFqU4WaxjPnKyY+wIbk8qVA9oxekn+KOOmeLZ1xLeoUwwgd3vNUWy6qXp3WFOD7N0PPNoT1q82E9R2NdRFcezPN+QHP26vvKIFZUK118COqgLb+2DqEO+TmLSwnTmxBrpTr12sNineUPu4eAsUHppaQLWf/MCk5s2OZKkLHzS4OqtwSCp1X6oCM15lRK8JTLhn1BjaOBGMP3S1RMjDP3IENIkcp9gwaY7K/jsAu0uSYjYi+qfiLzv/LjAeODNaeD4FC5Sf6O00u6EmdHrkYTviiH2cGwzSyH+soE1nIVYkZg+LsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ+nMZ1GwIt3hxzX2PIDZ0X7Ti2Aql0xNo4Ut39ZR+E=;
 b=lv96mve3FNAzQNJ/Xyoty/WP+LopWTCCL2LbeMmnFMTw4fQWE2wBpdgwKSmkWcaINIH+ophgaXatwy7X9hDOOWKKlmoan0c5X35+LGm10dQ4IecaCk38NsHobKM3wrEWe8c92fW/7wQSl7yBp5j3hweGI/yE0wDNYE2Ji11Nyv17r4M6JPwJDBxHMXw2nRCNf+ETJMtVIq4tH+Tt6s+D20BKU9UV+1fuQ4S42XkzzPUs6OYRdZPN87VGhDRsPzCcsxGb1rBpMays2A8SPNS4dgNvmSiLzQ9Tbdj0qSVLu1cctu06hs0pSoonF/RTlyc9yUb+wi0kQZ2HvmfLpLsm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ+nMZ1GwIt3hxzX2PIDZ0X7Ti2Aql0xNo4Ut39ZR+E=;
 b=MtDmVRtgyQme1kpdkqAOj56zlS9QkFjIhoEZs6NAa38+0oCzvHFd72vbLqKC6KNXzqieV292nNAYP6t73lIaVU4hirf2gFMfVV7/WxiSiVL1gqF1Jhjsvdk2Hoy3uEewb8cTQ+eD23wOdXfJtRZt7WTPxtMSqIU5+Ppo7lb7Se8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 03:28:17 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:28:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
Thread-Topic: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
Thread-Index: AQHaooUaclJa6tyd0UGezcnH224mmLGPzt6g
Date: Fri, 10 May 2024 03:28:16 +0000
Message-ID: <PH7PR12MB5997C6F9C63C3C37B5C79EAB82E72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-5-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-5-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a2054de7-ac18-4f30-8a18-419792954b01;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T03:27:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB7805:EE_
x-ms-office365-filtering-correlation-id: f37452d0-09f3-4d9b-675b-08dc70a13b76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?kTPRAUElsfW4uB/549mXwE85TWpuerzBzVNpCA77uOMlQJExYlSH5MGlyfcK?=
 =?us-ascii?Q?uXvpgQq+NLOXAjNen2Izy881Hi9awWOu8IM3t73gNugY1NBbm3GLK3S6OQMM?=
 =?us-ascii?Q?O0WN/SnnxAx68Q+zAso/BcYhZSTVqL3vhKuATUgsQTKAjt3kljDlYX5nAca8?=
 =?us-ascii?Q?dZ/gRP/C4QWuGcvzowYKicFeLQceX2BGmYqWlHZcHoVk+C37YzBEBStrX5i4?=
 =?us-ascii?Q?7GhIImmxGNf1typ9C8p78BFiFjPFKz49Swj1KR/TGSOGyzdrWzp1j4llMKcS?=
 =?us-ascii?Q?bZAqTOek176dD/zSM0l12GafAdYYn0mkF0gNGchcPYm0w0UGoGnGxbOY/UiJ?=
 =?us-ascii?Q?C10YG2PEQs5egBUohF1dI7QkQSO//bEzqlTX0UJJiAp2pKeNULabjMasyDDH?=
 =?us-ascii?Q?PscKPQ0ijPF1lt75M01uDvICNFxqaSmlBs2IjGQjshWe4Xn6m8tLBD6NcySg?=
 =?us-ascii?Q?XOKjAv5vWD0RkV4e5OaDSbRli5h8BWxc5cggA3LeQQ+jSnbqTpqWmMUXv82q?=
 =?us-ascii?Q?e5av155RvMWEHhslPKf+/Tq0JjNz+mWw/BJFySFfjz9OE3+qj16ENQiwJE+P?=
 =?us-ascii?Q?1ee4Km9FmtWuGJjNGQJKQJ8UdTgytQZoEF9TipoG+8pn7BNGVVnCIGWTHi74?=
 =?us-ascii?Q?/XLIiiZzRZi87y3EvEFJk3Y6mSaBEdvRhm1QIPXuqRLlga+AbI1YK0ToV2CX?=
 =?us-ascii?Q?RWIxXRiSdSyERvltfgvoz4JJZROKC4UhT4CDGOEzJZNY2tdrVJ9yUcfyuU7G?=
 =?us-ascii?Q?jBQYAIiC8p2DDCVytQjhCEuxjWCF3/Vm+eK2hcPZrtJAy9CLSbghNG5cgRKl?=
 =?us-ascii?Q?3QCzD9OhGhi3ZAXfKkwFg2V9fZbG/AALEIVlJqkBq2m4URfiBg8p+rXGH3Xa?=
 =?us-ascii?Q?ONtI+ybGQn29TJJ7U3m8sO1AasYSUj3X6IbDESN45p/KLrJKAFek28DY8Rqx?=
 =?us-ascii?Q?0+PSGGftsXq7wYpxrMRqBS2A8ES03wELx3nRAfdhtLhqJLJ3HXj21LD9LakK?=
 =?us-ascii?Q?wONjjBgpKnJFlcv2PoKfHlgD63m/NFvqE38Gx/pDAOAdLlg0QemdTZh2kSrg?=
 =?us-ascii?Q?itZgSh+NcAUQHwTH653KB41corEs08zjgVQmGsGsRmQdUZcNO61bd+i9PtwL?=
 =?us-ascii?Q?mz+bgpdC3WtQuWiqIL55YTI9ArQv8V1EDiNphN6D6uEZ/llKUiQtHXeIxgPd?=
 =?us-ascii?Q?PWULTEzbcOYzvnESzUfdCU9vgSEe2eMPIuOdnXjaRDPeoVHOkCoTOxpmSaut?=
 =?us-ascii?Q?tANJGnb+bQ5zpUd0j/5wmGHAL6P1QZEgeuDNvJ6BcPPpq9T34v2P+kTS7POr?=
 =?us-ascii?Q?UfcGUfB4jAAfyA/w4S0Ylsymq6ijDXAoEp7jiMoajUnGLw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3EoKiMAV2gmb/NrGoU1QM6VyLMc4wkj0Sy0H/QIMGVEfRFkL/w048Wgf3ZZP?=
 =?us-ascii?Q?p55porFe30FhOex1FkNOjtSl2IZGYaYajY2/GMOb5LHU0CUILc7uSJgmJ75S?=
 =?us-ascii?Q?f3QK+kVOHGyroA0C4noD4W/jc7NkwDkj8ge1JQuuvxaDTZ2aavDdi1tGoVY+?=
 =?us-ascii?Q?I1zs5XY3vVhfOsQpuFCcBR4iUHQitAfZiWPUEd6mdRffolvvVll+h6WE+Kz7?=
 =?us-ascii?Q?98vx50F3ESNDxwjFWw/4o7i44jxwOuJ0UyjbS3UNr5PBZUJSCXK2cI+nqh12?=
 =?us-ascii?Q?GaNAOMwduo39cd7SWq1ZYoRjLzTtIax6xE3ae9Hxz8PGVwgY24z2LrPDLvbL?=
 =?us-ascii?Q?Rg4zQWaZaEI06+PCeW3Ir405ko9k5t8Tf1NwDhQUHT5b7L/Lz/VHuEWSMBFz?=
 =?us-ascii?Q?mPJZoC1NuMBbdJLpDvvsug3uoyOvlGiuuaV2UZ/VojQoXByk3HnBNK+xD9AP?=
 =?us-ascii?Q?MAaPLYwT8OeuRHyqfck+Gw0BiCCIHG+6gTPahHCYk1YC+0Zt352pfS1Y4mlm?=
 =?us-ascii?Q?iTT30JAchc/AsWsHJXxO+X0nn/y6eGpYNvKOgFLIkaOPj+cvSS0N6gwqSYnl?=
 =?us-ascii?Q?4vkImva0g7v6+w6Bm0IibMrA7sFrNCN7niH3xl38aik9BH9jm7OllieCeqJj?=
 =?us-ascii?Q?OWlBuMKXxTfz3p5gpItJ9oEjGdjVUK8EX/385IbQReut4lzcFtqKqoW+YQLX?=
 =?us-ascii?Q?2g57qOpPWrdXd4znKUhZENyaANbo/GXny6KLBtAoZegWee6HhD0JUa2knPtK?=
 =?us-ascii?Q?eVHMCaKxm0HMOaElInOF+XXxZmo+AOWdzy/jyxE86M7OaI151wfxxV7fm30P?=
 =?us-ascii?Q?hs6009AwZfZOmB0/jShNP+ygVkoqFiaXdh19Z5HDWW5TsOSxIRVRRYAQa74C?=
 =?us-ascii?Q?H7HYKeko3t99YGjKnYkpFJOMY43ywU8trAU5igHC3g5pg5Yzeh/fGjuQwqXh?=
 =?us-ascii?Q?jrOmkpn2FsadFg6aRUZgt3LxWR3JSZmLYOay7MgUongpzOQXexkb4QwAEyza?=
 =?us-ascii?Q?rtF+kYg2UyYaOzk5tUKYkJ2KDAH8UAjiG3f7gywxbGZX90tPT4uLDvwZisjU?=
 =?us-ascii?Q?9KGATE5btts5QD3DpsjBPyKjiDqKfPW5APiJjgKpimMN/a40CjkCwHNgZAVo?=
 =?us-ascii?Q?JaNtlO4JkbCBLlSGtAXpAh46OQMcFw5bgz+wdkID/d+ZW0YKXiGoY62np6cv?=
 =?us-ascii?Q?IAPnnUnEY2TYRZ0x4EC73A0bTGKYEdv4vgdxNDPJxBJHDAOG4fu6fNMtElHN?=
 =?us-ascii?Q?FQi3vCu93a0Rj0LZFy7/SiOn7g7byBIvs+nkdo83Mbf3waOS0+9KLERd2GFv?=
 =?us-ascii?Q?fK8yitFgtPKaRFgVZefHfeSq6lEYUjJhyvHtezDFkC9z2a/bpnZ7W7AhWw5n?=
 =?us-ascii?Q?6Q1IOVJRJFfYRNUSKaqUAPwXK7aY4YAkMOiGG1VqrUZd7d2jNUcRg1t973bf?=
 =?us-ascii?Q?+YffxPgNvTVAxN7U6bM54GNGoSFPLvJa6Jr3PS0m3CFCXrgxWoyeNKm68zo9?=
 =?us-ascii?Q?5VzfT2qFYDx3PbogHmkFM1e7Hy3/Rq84U2gJE+vsXLl/5jC48ywM4k95RWHD?=
 =?us-ascii?Q?Fq4ng9N40/6WxoiuOQ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37452d0-09f3-4d9b-675b-08dc70a13b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:28:16.9060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiKaDRRzpaiDmbE2MDUsGU6z+/H34yJP8h7+LMWklxgz+lNPfhaRSrf8CLU5CZU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran

Check for specific indexes that may be invalid values.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ce941fbb9cfb..a22eb6bbb05e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1886,7 +1886,8 @@ static int aldebaran_mode2_reset(struct smu_context *=
smu)

        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                                SMU_MSG_GfxDeviceDriverRese=
t);
-
+       if (index < 0 )
+               return -EINVAL;
[Kevin]:
Better to add a new blank line here.

Best Regards,
Kevin
        mutex_lock(&smu->message_lock);
        if (smu->smc_fw_version >=3D 0x00441400) {
                ret =3D smu_cmn_send_msg_without_waiting(smu, (uint16_t)ind=
ex, SMU_RESET_MODE_2);
--
2.25.1

