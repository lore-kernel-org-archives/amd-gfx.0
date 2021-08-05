Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB2C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 06:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D875D60525
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 06:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D875D60525
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1A889F19;
	Thu,  5 Aug 2021 06:31:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262B389F19
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 06:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGVNtQ75oVxfAY3nuscuK2qbLmbor0LPU135pQyqbqV5poh7rE7ziFbgzXGTepOPwehK93rGSDxgMQRKNGEvo2ozvS0QE4XP/RD6LaA1SSSd/5VRBQzQeGWXYuzqU/fV7APWCcR9ooKWY8LOgtLXYMnE/ehZFsgdT8OtlCcnauJZFm9YJKrIIEA+XK85PNaB8AbxmhlQ0zzIiULjHBmRFjN0bs+pag1THocWrfVfWRZX3MmEo7vBXAiAygLPO/Hfz1HM2UvTtFY1kk25KFAjBUEX9vCeuqIOEeXlz5MpgNsWSJ2w60Tg69eqlMdqXZnzRh9aMgirajFzGl8k6w+jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmYtZeBD0h081hJWNbUvwkYErOInKzuQ3W1diOXt/9Y=;
 b=MyqhD4Io0AF+vY6lweaTzdwjxf2RqawW1Z+8N4foj84S6dnZZqn/PTBfd4E3H7WtfVqcNGYhy1ViAxd7CNpm9u79pozSQym0lVyKfp3AI4UmjU1QATaoN466lynvBadQEp317COuf+sIjEmaSvX/7eK2Qpn6GoSk3hGrMDpcXMFuFkCrc0dVmXIc0vlldM+3gMbGI6WZAVs0/sRhkKCfhE/NZBMoFrU1fDiH3F/aGMk9pwy/EOno8VpWmjPZvZgpO5JiGTwHvoY0nzaGVv4Bi2ytXm6ejb5GdQVVTV1riaGVUnnhAIz7rW+L8APHRryVqA0BZl2QT2317+ENsXtweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmYtZeBD0h081hJWNbUvwkYErOInKzuQ3W1diOXt/9Y=;
 b=lqSmMgAw6g2nAVLCUsP+UiG2Qs7T7cDLBnicrsm2oyn7rRCLkg8DkO7Ew9Rk3+Iu4QdSM+nN1Q3ewvJojgeDbdn4+iC2UzzdkWKgTkELb+4ECE0RZtaz1TNs3FZ7LkDccKyDZXJldhmAw2xQRnXXy7/5izzc6gej6cD+e62XlIY=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 06:31:49 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::c803:b1ae:e7f8:fe87]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::c803:b1ae:e7f8:fe87%2]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 06:31:49 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Nieto, David M" <David.Nieto@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Topic: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Index: AQHXiQVtEMExS22O/UmEEi2kycEOx6ti/PlwgAF3/OA=
Date: Thu, 5 Aug 2021 06:31:49 +0000
Message-ID: <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-05T06:31:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6fff13d8-1b1d-48fe-a29d-d2c9d9653d2a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07a2f547-8db6-4dcb-880a-08d957dab4e9
x-ms-traffictypediagnostic: CH2PR12MB5515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB5515CFD55FC8B31D5EAA83A3F8F29@CH2PR12MB5515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjoMMot8kVhBwAoV0y1q4IBBOhwmWhz5QrWdmX5xnW4Z2dBk9h5v2zlaif6F0QMTp4n2Rkz44AZtrpb8Fa+klt7Ryfi5ZVHF89un2hgN39JE5XWA2qKTTiqgZA9mDMCrI3mbjzS/a19AKQaVAyPOpAelDhdHtIc0O9yZ+Nf08OGuGXhHDN7G9Hh1LpyfjjTkLVLjivTBD6xQrgGYwUKrtP5C2OjFds2JMPIGaKMEaaGiFIudd4oIRlW3/vtGUFuy7Hz3V5wNF5W0cApro82DO8px0n4EXQqT/whHdcZuph5cMjB+jwkKcvUjHOmAxLkqZj/ND1+je25fpnW9yW7yecSmb+TQP6Y5gIXoOsHqQdBjbjLCkiqvhySiUoZ0tUSRMRGeg7AGDEjixJKn8xd6IFgfMmCYeVKdE+utWCmXRTNQVXBhzNn41a20HbRPGRDxJgT/IMuZOhf61iRJv8oH8grZ35iNMCRtkbHB6d59O2CQCNPgP9E92u+dxrGxpm46CrDd1LSVVSfI7dqu36xpQzTxPuxKy9KoFs7ysUvWDp04I1LSfuO3QeWhFZU+E7qENZjYPMP6iTM7SUpKqnRMgJXRawlUQhIK2eS5JzUrq+64WRwVEMssgXtw+wAsJeu/SRz12WY4gGfriYaarAEWFxBi/VgMnIEuFcgpATs1o3mtwfddSpsAevpo411s7UJMigfTMFX+0E9yrTmGXEfFyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(26005)(54906003)(66946007)(66476007)(76116006)(6916009)(8936002)(478600001)(83380400001)(64756008)(33656002)(66446008)(66556008)(55016002)(4326008)(186003)(6506007)(9686003)(53546011)(52536014)(2906002)(38070700005)(5660300002)(316002)(38100700002)(122000001)(86362001)(8676002)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/URndd10Ncrc1h+27EYz7TpZxbeSx9cqqlKJ5+J10mRm9LRuT56XednkLTzI?=
 =?us-ascii?Q?GMpfg9RUVlPt9ySMqqILhUYb3KxQQ2+F+WGTV2beX7O6B3oLs4fBPqkYYDGD?=
 =?us-ascii?Q?hd9mz0qWvJto8yo+BfA/NI62EHP9D0gBUC3XFXDJ66K3WV8QexoQJmSOATyr?=
 =?us-ascii?Q?XxJBDgxWiSs52pp62F0KSlWMEev6MYksHT625ThJyJv/o2BitY3/FjpXwIY+?=
 =?us-ascii?Q?Ke+56gAgpMUBLYUXOdvioA5d0/wjD/6zJVT7YzdlGSLghyRiSRXiQ8G2qe8r?=
 =?us-ascii?Q?ne842y/PVwFbCpPpUkrzqzkpOJ9Uyt00mJ+c61eYTDu3+DsiI2PwxCGAaEZT?=
 =?us-ascii?Q?gu7TAO72M8c7iS6dpeHm7E5kQtKYdpHoF+40pKcucZIqFkejk59cX3tP8A9f?=
 =?us-ascii?Q?nRlAKAJIQbM3tpVfrphPqtclxl5pvYL5oNmpAJwTLaOGhoO9b9xpKSeiGBFl?=
 =?us-ascii?Q?EDzyncpDbKqIx7ibAWJ+SpXbF3bXnv4IQFQ19VwMXkO4KnIww+Sr4SosKGmd?=
 =?us-ascii?Q?SKrlfZmOuVl98x1t1Sz4QRs1gH2TcC/QEr+4xtgLNqXK7JLr12Js5PGepzRl?=
 =?us-ascii?Q?zrq5I2MPxbzsz3UZ3x34kAgTnhyKF/LuZGIP58xUjvPoAFv3DTS/GlO9f9Uo?=
 =?us-ascii?Q?ojAoU5XyZ27xJaFNFnjR07qlLAoQRqIg2foHOMgmankaTmUOahVgE8W+BhJn?=
 =?us-ascii?Q?EyrZqUxcv58cVzdmNSCMO1pkXFcsWCRjzn6APNAjXdLkIr2zcAk1wSElYSOA?=
 =?us-ascii?Q?FSovbMLy4l+falHG0HqhSen3wn/sjJETHYVUHIJ9udxLCWT3/jm+BVEOxzK+?=
 =?us-ascii?Q?Lccda/GcWLruCEHgXqelSKsIFP5A7Dq5XBrSf/0PU3//cBGKflgVIMJagfeO?=
 =?us-ascii?Q?nbHylhbuvdEwkwCbB8F0b9pv0oFNm2xysFCfRk9BiFHJt8itPBCze9jKNWPP?=
 =?us-ascii?Q?yUjf1SD2Doac7zxKdDntJi/gio8KaWe0DzSVZPdr0MDTWPuKBt1zh3S9UE5y?=
 =?us-ascii?Q?m180PEWtjw843Gm+OhIHrlRt4YtoOmN9JJ340FmefHeoa8isMq5p/dldzeBG?=
 =?us-ascii?Q?HDCsggp/ngYp45903wIIdM6OO4X6lhMHSfHGJxqbbBEDpobh3vBHe1RYKsI3?=
 =?us-ascii?Q?NyFNNH1M3eUtplCNrYXx9iLcIcbq+5SONWDIIpBumWoY4m6gKNZML/LstvvV?=
 =?us-ascii?Q?zx3tGqKkoszVotSopB6B41cwSm6iIP47dmkX6Te9EXen7TpumDoJPo4ANcU+?=
 =?us-ascii?Q?Kx6Y9HjOUt3mf6OnigFnUvvkNxBgmqsY8bqRLlNGQyQjmFbxdwilHMFWOctZ?=
 =?us-ascii?Q?3M3tmoUrq95hP4cQkklUAlQS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a2f547-8db6-4dcb-880a-08d957dab4e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 06:31:49.7703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mHPfWL+Z/RbzKiAh7OoIeyNkYXRdNJaNumn55h0NVtoDttJ25oyzYpBHEPYRFA2xMtwFoeURriC5yexAuM7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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

[AMD Official Use Only]

Ping.

-----Original Message-----
From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>=20
Sent: Wednesday, August 4, 2021 4:08 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode

[AMD Official Use Only]

Add Alex.

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com>=20
Sent: Wednesday, August 4, 2021 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode

Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under SR=
IOV 1-VF scenario.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 769f58d5ae1a..04c7d82f8b89 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_  static struct amdgpu_device_attr amdgpu_devi=
ce_attrs[] =3D {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF=
),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|=
ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF)=
,
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
--
2.17.1
