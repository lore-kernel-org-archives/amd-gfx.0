Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A15C00140
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 02:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EB2BEFAC;
	Tue,  9 Aug 2022 02:48:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16A5BEF7B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 02:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Z8UCTMySb4wKn2jFzBso7+M5T6OPDOwaE2qxEkeiI5nWT4YyGve+4FmxskaSeLiKpcDpDVtvQ3/yIeA0Fs1scmn58w1D5SreoKMN/WGSC6qloxC+uPTbiRLJqGgfIBC7rxOSMeT8oZOhlf1LieQuusntiN2erzfVTc9WEkLERL2eXXck9JZ8hq0hw3BfnI2RSqfE/AfLIdIBDgJ+cXDg8U9g6NHrm/SqrSkYu1XjOWXDpn+Htq8Jvwfb7xC3njAqDKrklU01iIvE6VqamlgkyYItbt/hT9Igvx3JksoC+ctV2lc5IcGwlGR6mkleJbq1ktDfjIpfgokFeIkqC4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sv6LunTdrkojoUemIZU/potOchAnhngkF0FklmEafQ=;
 b=QBgVDuD48gYd9oJit4y/DvJSQMp2p/WtvvA9HQm3Z/4gok4zoW+UrFg8+K25aOIIDJD6qd6sLsZl5JGN3ouCQwkEYRGbZqUoFGDz73xgNnHUJJuBBBXV8ijRP46q8w2/esGp8rR6Duzzt6KRFcRSjvewtwqbezSIFe+C0GDguTOyxXfEdpXP75qPSX6J7FE8GfjleD7X1D/H3SM5HwupjEIpjmw/cBxZGThecd+aDDngtZ3fR93ARb07d03Nd1iswOSOFmxqe+++EYzsLmKb0FR/jjFVSEcNON0infrArXdvV184GD8bHXXkNLhZMpuCRTN/JrEmapUxVB2UIPIuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sv6LunTdrkojoUemIZU/potOchAnhngkF0FklmEafQ=;
 b=1auz98xeRu0SEXNLeBoSQOt4V8FVA3YQQb43HirrVFcZ0ENkkCWmBkLIrQT/4NBxcTrCO23U10eWiwp/dbUHoI+nhAfYm0HM3qKkTG04rID5G91Sg/N5ENtJYcwaZxuZbLNhD/Z51oKW30lTtWNzqdeShLzkP/N/Cg/lF5w60DA=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by MWHPR12MB1949.namprd12.prod.outlook.com (2603:10b6:300:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 02:47:52 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92%4]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 02:47:49 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add 3715 softpptable support for SMU13.0.0
Thread-Topic: [PATCH] drm/amd/pm: add 3715 softpptable support for SMU13.0.0
Thread-Index: AQHYq4/LNUbHznXQhUyUivS19lpX362l3aiQ
Date: Tue, 9 Aug 2022 02:47:49 +0000
Message-ID: <CH2PR12MB41527547ACDB47FE937B43AFFE629@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20220809013101.1751952-1-evan.quan@amd.com>
In-Reply-To: <20220809013101.1751952-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T02:47:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a6b09410-2f3b-4763-8b4c-de61cff9cbbc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-09T02:47:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4fa0d639-5197-4124-b488-ff20a349a609
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f2f1d8-a9d2-4629-1a3e-08da79b18c33
x-ms-traffictypediagnostic: MWHPR12MB1949:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLyAc6AtJvk8AuCcIw+unlQNUY38obt1fHmBua+5LN4oJGSCEwEBvYqqAGyvG9DC9MC4POndwPZi/ZNTHPu4rFoRVJVMubjUWuQ/1icjEOoyZjfjXay9ntKalqcR3ewkWth6t/+bX1fWlrmisBvoworlkMpz3IXc+T/dTVoMoBZXkdxv43kW9WwflomdF3RZQEY8x+pJQJnjNFL2wGqczjvZMz6k0VTaulxxXiEJh1OtTpvz7oKhbpokrvQPUhidaQjoeU+mS1NswbzYn6DrUiBE42dOHsx+sJ04NahCShRuNymIgvn8FSjzNdJgAPbrwGRwCz9T5I4yI9PiI3ZpggkrFvdasGwB70acRtFY4UWDO0SlWfZUjrbmnKn+HutMzp2FOO5M5tI198pKLIIgPU4kpkcn9RRJNqPjI8dJtkhymzWUkApWTpRD79Nu9RWJxaFjFZhIjolTSLJhK5gR12ZeCtdFUPQP0y+qB50zYZC4a76frODF2eSLcGQzloh/0tFPgbvqGZ8kZPOYvrMVFa5eit+iXVzbcyLtFFgDmGZ+5T5F035Cq86v2IOYy+4uvEh0ZWO4YXTrQ9bJ2N6e3NzfUmpXVAZxUyAd7WaR34q9NeD4JGZO7sYYdg87Xn9ZH7N/4pCQu0BOryt7VawySFSe4PgjHDBR9Ruu2NGBr4d8RcFkC+x0yIWp1Mg0+BJK73vYMok9ZRnXVPifLMe+w9/hct6EG/Osw44LjIkQaxLShc9xjRSsgJGFUp1abfLvuZkXoM1TfRy55CQ5iBfNXB3baULQsaf1kzwINTeYgVILFdqUcN0oL0+Gxmi/7mx0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(76116006)(122000001)(8936002)(66476007)(66946007)(66556008)(52536014)(38100700002)(64756008)(4326008)(38070700005)(8676002)(55016003)(66446008)(5660300002)(478600001)(83380400001)(186003)(7696005)(6506007)(71200400001)(9686003)(41300700001)(26005)(2906002)(53546011)(316002)(54906003)(110136005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Dzg1Mm3Ah12swxOwaNQGs4YK3RL7WDyTgJM9J8khWd4P7WzbietTU4SoaQ6?=
 =?us-ascii?Q?W7AgvMPCZvKFqX5nnqNs6brWczp4w8i+Iak9hx56agartVO9RmFr109zUCfE?=
 =?us-ascii?Q?ZFWrfyztFUZ4HuRf9Pv9TfwyI0X2wmev1fO/aIp0xD2cJSIeaqMeor+j8lVS?=
 =?us-ascii?Q?zsZ1mBxDdr5bxqGE0iQSMyq0vysv4OD6WN8tJD2P+dqeFXXjLTkjq4SclvZV?=
 =?us-ascii?Q?kaCMc8Id67KBKoz9QvK2UzlMvYGEjhsFPCXmH7J8K3Sl+52ZaQhIyIhbP/vp?=
 =?us-ascii?Q?Z6mJQIEI7bIf4TGZ6NPO2RwYLH48VVH5SDzr1fFJe26JtiWPYf+MF5us1lo4?=
 =?us-ascii?Q?XyO23e0bMyfDiMH4eHh069dhKi0JGI2S8KrB7+r8/Ty8WA9LbDnFpMsyOvoR?=
 =?us-ascii?Q?/uzAafU6vWKrZL6sRNT/FHco4Dh2zqBHGcKOge56K1BE2n5GB/HYRwKxhN3C?=
 =?us-ascii?Q?p/U/EbhyoupJx1vKib+CfYabl0UQMxQ8iKKWUNYXPSFjq8sL6UYvffe8d0eS?=
 =?us-ascii?Q?8MQNCLZEarLVuHePxQCXtOQkpGdSIEvK9zWklpMStmrl2bReUZCuk4YDdQ7V?=
 =?us-ascii?Q?3xJCvH/p5qSmbPVeeDnHfMV6TaIdd7my4k+Rih0hPus23y//sc2bzXmU6Vf3?=
 =?us-ascii?Q?rev5QNnwfHUPGhYXHf02Va1Tz4U34ANyR5ppahH+Z7outtYwgqO2xj1995KV?=
 =?us-ascii?Q?cWFCxlFfBC8v1kO+4DhGqJDeSn9UdFxtn52FCaesDkad82caoxsSKoLvhCAx?=
 =?us-ascii?Q?Aq1So/he5WeKVqsiCSuM3G75Hrvos0sx+RgZqM4H1RY4Xz+43441CwqWkgbl?=
 =?us-ascii?Q?GvAALPWCbpQCDAKwdQwuQBwyWxuVAgJvQHlBztjYKSE0ZvolePZRpMjB77Sn?=
 =?us-ascii?Q?0X3YSCKWnNeglFWRQgVojwhJfc/yzCQxYw2brb4pAZEDr3ufQSb8BxCC3UU9?=
 =?us-ascii?Q?CzNpbmP3nEIlZVy6fwpPclss8WIUcFympmZi0wr7sASBa9qxHqmkkj8dD8ki?=
 =?us-ascii?Q?0soXxoDJvz/9h2FjceVz/G88QxoQdz1c6QaGojS+KwjGaNt5SN/WBaY+jjmP?=
 =?us-ascii?Q?fm47Btr2i13BxkhA7HvBjNf4y4tehgEcgWZBVrU9VNvobfjPybR8lqLFF/h4?=
 =?us-ascii?Q?Nt8nLLqKsHUkSZfepj7cXOrqb4H+qUDOr9ZW0/IwiDdz23ytjWKojNC6VW3e?=
 =?us-ascii?Q?c4PhlQfFD111a/pHodMmmvXKcfnTdpjRi3lebYijdJ4SeN/GYWccsBOa9/4N?=
 =?us-ascii?Q?JxUUnqqLDbwG5Mgi8XIWT85UMfFjfI1z2cz8vakZXOofGRQAuPAgoE10VeHb?=
 =?us-ascii?Q?+i4N4TRdMPBWd7WqS5oMenS5qbVf1U6qwauQ6+qI/kKWBwyDF0FS/pTz2MVy?=
 =?us-ascii?Q?bsPKmS8fjD9acIoFxUiOI63Tpn8ndpVDEzl3+7KyCVvoHxqHAe9Y+ElooIC5?=
 =?us-ascii?Q?chffZuKdAU5CdIJGEC6zk1DzUwOH4dFuk09M+/2tZPQJt0PNKVJocg4fds21?=
 =?us-ascii?Q?SPyup2DcO4QQQAOMDp2KIKEsfRUkLZVbd0ZzBKeqt32Vswxe09yP+GpIkqjL?=
 =?us-ascii?Q?MDvN5O34u2iPArHFOPo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f2f1d8-a9d2-4629-1a3e-08da79b18c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 02:47:49.4052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qzmTUPqu/EulU8Av3y09YFUZPW4eZlf6FM+ZRFyHE5Kd3D6cVV7WkXJhFn6w1Wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1949
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
 Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, August 9, 2022 9:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: add 3715 softpptable support for SMU13.0.0

Add support for 3715 softpptable.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Iae7360ce853a6b5fde38025d528640c9b88fc54c
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0370482dd52b..cd159e240147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -229,6 +229,7 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
 		 *   - use 36831 signed pptable when pp_table_id is 3683
+		 *   - use 37151 signed pptable when pp_table_id is 3715
 		 *   - use 36641 signed pptable when pp_table_id is 3664 or 0
 		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
@@ -241,6 +242,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)
 			case 3683:
 				pptable_id =3D 36831;
 				break;
+			case 3715:
+				pptable_id =3D 37151;
+				break;
 			default:
 				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
 				return -EINVAL;
@@ -478,7 +482,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
=20
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
-		 *   - use 3664 or 3683 on request
+		 *   - use 3664, 3683 or 3715 on request
 		 *   - use 3664 when pptable_id is 0
 		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
@@ -489,6 +493,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 				break;
 			case 3664:
 			case 3683:
+			case 3715:
 				break;
 			default:
 				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
--=20
2.29.0
