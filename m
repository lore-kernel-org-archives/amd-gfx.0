Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF4DC46467
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 04:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD8210EA40;
	Fri, 20 Jan 2023 04:49:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBE210EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 04:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chmtooJ7T9M24iXpSaxYSSH2MHfO/mI6n8BkTFEf6AepC27u08hEqLytncqdI/PLmHc0LCdI0ZwMlElpk7V0HJfGC2eQ7PigzU0G+yYgfxpG+SKBVKvBXB4qHXEzBq5oYh9UbGSguQmLzQSjjQM7YoPd1lSQcgZXa4d/XczMHH0AaxwYYrqxtTogQbC82O2sVfSTciqC98qeLWFTjlJnZFMavZYSc9fGIUt9+2Bh45xCuA+1Eqh16ul9f0DvxF3gIetCEe+/B3y+PYPpZiJ8rK45EKczwHSURqpu/osVoVtnEvXUL/8CpNFrOMZAvo3lBbhEsj9cR7kL+dHoG+akGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gua/IZ0sOutKERAx7B7F6ViDVhECtTIYLvnwGzT0DHY=;
 b=XKlg2SgHp+LbIyf8VowguDXU5cTSXz7pGX3GF+tHZmdHwWNKw/LxNDO8wvBLtYaxP+Rzq/p/wLmt40B9baBKJjyI8tnXpfimJHKfLttM+gx0o/IJFVs3XbKGxw8jvbSaym9SALVqg2g+iOleFvjIrD33zAr9m/YHXCZPVOZlwcL3sHfLJ6ZviFLQR8ix6Ozkr826V2ao09VNQTKWTFjI5vMO62nZfOlzh9rttbQ1TU1fQQUOqKLtK2/F1KavN2FzMxXWqtxKF4juyhV00GZeOqOjR5sa2Y0/F0Euxeh6NA/CdjuyATj39/1gkEE6tHNUuWNwmyplWuwxfQfvz6ACmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gua/IZ0sOutKERAx7B7F6ViDVhECtTIYLvnwGzT0DHY=;
 b=YD+0zARNSSxmOD1NXHjKcvLW63QD3IwuJlUUrx9ZXNZpGmGc/pro8YHO8JlbtJ/2/pZQ7P9nabzWjS8H/hU0TmxNGH6KVKqRMCLZaNSaDH/R4AWFtw6rajvPCvy7TrlXVTlyzHgwsdXPUApvbji1qSqgeVNljJ9guFZvXjGG10s=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 04:49:12 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683%3]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 04:49:12 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add missing AllowIHInterrupt message mapping
 for SMU13.0.0
Thread-Topic: [PATCH] drm/amd/pm: add missing AllowIHInterrupt message mapping
 for SMU13.0.0
Thread-Index: AQHZLH9WACi1H5nbAES1Yym+nDGSDq6mvAgQ
Date: Fri, 20 Jan 2023 04:49:11 +0000
Message-ID: <CH2PR12MB41524B014101D1B2A08CEFEEFEC59@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230120032825.2094786-1-evan.quan@amd.com>
In-Reply-To: <20230120032825.2094786-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-20T04:49:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e28a4052-5332-47ec-a8fb-65c155698758;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-20T04:49:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7ea19a8e-4564-45f8-a205-99c9d4f046c8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM6PR12MB4942:EE_
x-ms-office365-filtering-correlation-id: d11986db-6f21-43b8-b376-08dafaa1acae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErKsT8ZF7sS4E3mWql+UavKrO3joYmw4Ir/GEgcEwoIv+soNpVZNQvn36kakxKIuqCNKwkcx6J6+VIYUTxTHVVWAzoTi+A7ju3hW9P2r3j7mtoA8TcVW930zgyXxU2pNNqHKzKUsnp3IotDntT7pIGnFmzdg9AeUtMPdugeysn4kUg9lMoF+42ZwJ34JF6L3V5q/VmA54JJ1zASrs0smN2zDThd2Tv3GmDSb8RuWLA0haJDc9iEt1CK2G0gMAB9cvMYrbhhkD/iQTxEbpM4gjaattrYGdkNOgWa+pCd3w42AAUyXe6qPGxxA3/1HSYWZ3KYFX12cEXnLUjukE6LjkJVTJgwBO42ZTtDVcblAlZDqsjN2TqC1zlPFD+kbbocWBqtqZvlyALYI9gFQgIdisvEwxIqeioFCsgfJqCKxwIsTy8ExQPOICoJ18lhS82cmYbYOrgoCwEzri2ulqKCf72W1EU0e4v2myvNG+BaGqIHfZXKancCIIBq/lGq06+TchHSe08YjkSBHXz/Awg11qQWKIKr3UeyfN1y6tl03i88OpotNXPyAeIJm1mdhf2y4uIfX7aCmK6BF4S3Pv3birTPEaNCXkbhO/0EQPg+Wt4+EcUjKntxxOsxHeJZp8tD6K8Vrp1glKkPaXmgpICzUYHZiYEcc/0CRC6f0mr+oWa2BJTT5JHR+6TQ3gVMi8AU2f8yKmem1PDSsLmC5BJV0Rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(478600001)(86362001)(122000001)(66556008)(66476007)(76116006)(15650500001)(66946007)(2906002)(8936002)(5660300002)(55016003)(33656002)(52536014)(38100700002)(316002)(110136005)(54906003)(53546011)(7696005)(71200400001)(6506007)(38070700005)(8676002)(186003)(4326008)(64756008)(41300700001)(66446008)(9686003)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XXpPy6WQ9krx/uLdUTsWBDJyy6A5HclSw4Xd0GvaZL8S2rw7q27WubtUz+6l?=
 =?us-ascii?Q?iPs5a9FP53LEjwYMkX91ObjesmoSnp/YfTgn3awWxsDDTAa3RSV5ZkIuw6jo?=
 =?us-ascii?Q?u7/gcUQqdIZiQuOegJOq/C5UUnbw98o4aN4H67hq6Umt/NkENPmTWXY/Vxlp?=
 =?us-ascii?Q?kQ1scXsQci4xldW4fKWkfkOS+X1cBKA85xdvyhUx/bVyAhGLe1zpvGQ/ZGFa?=
 =?us-ascii?Q?dgw6Fhf3ihxk7ZWpokE9DsT+3PtXc9sFoB01lsti+UfqoflY2S+76RAccyvj?=
 =?us-ascii?Q?nMoSM3A6q4xaii+nWd0Mfmzv2q2S/50U9FpVG+vnY/cJxe2MDY5I4kodIMpg?=
 =?us-ascii?Q?bTyCEYWAQy3S9SJTD47iO6Y+AAQsNu8mRswEVdwQ2PGfgDr7KbqWudujO90h?=
 =?us-ascii?Q?W2z0cuMVsDvivOPbvoCeEMFXOKc8Md5dhgtOqxwTJ7axjyih8WKbnWl/ZpKv?=
 =?us-ascii?Q?IZzVFUum2PutPkbaJq/mVTcsJCju8RfadFHanK8tsfaGutITu1ZX95vBO4rI?=
 =?us-ascii?Q?PklCHLFP0b1fZb6LWTaStHgJxckIcZdFKw5pxDJ/hOaHf7ywrL5J7MZXW09E?=
 =?us-ascii?Q?2qBmzv6zKy3O3A0PHudiLouSL8crVfsciL6xJn73eXcdg7SePa1dEe2hHarx?=
 =?us-ascii?Q?tSiZJyg4zsxJKAtEPHMT6l34QExqc0JpLW3GkyIzDKx5tNAPR2tmeJFpQHHl?=
 =?us-ascii?Q?aP5hzJdcnPtnZ80ZZ4FILmlk2zuFseVik3C7tIveXJTTuauphQgM/dAc7RP0?=
 =?us-ascii?Q?RDo3GZDXVm4T2mAGPSMa28u/SmOpjdVrl+oH9aI6YbPZogv4c7ECcZ76lye3?=
 =?us-ascii?Q?as9jwfudAsHY69OsQTEcyIghS0QF/ERavrjZ9FJQU7+sh42yXd5CpBiZ4MXV?=
 =?us-ascii?Q?/bXxDAsUgBPvQ8tZKmSYUzefcb1Pcjn6pyepYRG5lecu31mrSp+C0tEhGfSk?=
 =?us-ascii?Q?+PE5X7bZ8Di9oOHfTM+EgVWFx9FcS+z3y+YpNAupT1RFjj6876tVl2TPDTOp?=
 =?us-ascii?Q?Yb1oqFspI96fD4GxJnYRZife1jntaBQdP2hNo3pGIgjTOdRugdD24Re6RAYG?=
 =?us-ascii?Q?0AlI1D8PsQnVGHrXDt44xTGUXO/EKBEOOMofgPtdh837nhFVr0Z03dpUzZey?=
 =?us-ascii?Q?SCtFmBZR+125zgc3rQ+Wc1sd8y5tco5gS78f58zs2bw1jdveEII88oaKzH0r?=
 =?us-ascii?Q?sy594/Q5ZzTSK4k84QEsyMr50C07XyS8jwlCLqf7Zs51R6/A2CLr1JcjhU1j?=
 =?us-ascii?Q?kdWXrAD1QDFzu/vFZ8rJvuexAQ9N6Ci8aIVWl0J11jMOmNvYHsRACyprnJpY?=
 =?us-ascii?Q?8+ECaRdO/xZzn+OWoLwWS2jr/eqrQ4OhEL3+UwKo729Y9MoEnE4IDQZEmIbD?=
 =?us-ascii?Q?VlszGPGQ4sfo0FkYulNxQO2kkyIMBMr2sWDv8ZvfifaAOfz0QAZGFerJKwYm?=
 =?us-ascii?Q?PWT6aXIPqoWzQW0/SXFj8viuspHyQlJ9FD5UZzQmcdsEJz7xfDF6TE7oaaTv?=
 =?us-ascii?Q?vjDuzt9n9nUhOpx/l235PAY1FXJxLNLlm+vGA8HknN1Qmv5WlJeyKJee0ZRU?=
 =?us-ascii?Q?Z6vWmyI74HZ0kIIdplI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11986db-6f21-43b8-b376-08dafaa1acae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 04:49:11.9686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vau9nNf/4DIEBwRdfrRQj4Fmgx5XpgLt0su3p86573WX78MHVkHPBkgVe+fUoec/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, January 20, 2023 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: add missing AllowIHInterrupt message mapping f=
or SMU13.0.0

Add SMU13.0.0 AllowIHInterrupt message mapping.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ief5f12215572a8029970e79814495e67d20f2388
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3fded9d2c20a..5ab303760714 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -145,6 +145,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_=
map[SMU_MSG_MAX_COUNT] =3D
 	MSG_MAP(SetBadMemoryPagesRetiredFlagsPerChannel,
 			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
+	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 };
=20
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D {
--=20
2.34.1
