Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4463C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 12:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B3F11A689;
	Fri,  5 Aug 2022 12:56:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D348BAA9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 12:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF9PecTigoKymPln3W2PYWqlRq7MInlEPP8zQLW+Mowhl1bLjlcwhy+QCB0FbOvky3ucMt5aYB7vU//7q5PsNT5KWkF4W5nMMFr/U7ZVbHQwWs6T5GcznNoGpTk9T5WQ2dBu0xlDhUKYpOYCc70/GHw9dObSiiZE6LZz9QfvhgxwSgQtIZwHAGhgYeiu7T+6TGRi28lU1agbUXmCS9sz+Ten1aV3LMyJi973kniXmZtdd/D2ayqQw3Ukars/tirKacuotKUILd3Ej4rZqLLgyai82FYh80UJ6y7lSWao/cHwkXdo0px5J5avLkSusJL1vhG4aW6TVcv5uNjhavz/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq9tiiXdibRZ3aQvCWrbsAELRy4QuthV/PtWfJS2qJ0=;
 b=GfOQKP00uXSXrxyVLoLgEDaZIVdsPsfRH0oYJ+qy28bQEFloM2Dv+lgRcWQ/Thazri56A46uL/BaCe24ggEnxH6YtDiQs+fqEp8NAGvfMd0LYEKp4TSLUXdLmM+g3xXFl06WzTXXerDgSsJZeTA9ZySJ+6hU2xfL2JofdkA0IKRpto0i2ZHSroSpA8RooChZVE3msA6s0kxnmKwVwMD+DItm6g1IM8vf482Cy/UOWcNSq0S5bbfyF+7yGC4BWoql3ub7Dd+Vpy1MHJOORlpXsJEP2jfN+7AJhV/zRc8IAAtvkMfluvH5rpFrEvZ0lMfcbLv/LRSI0Snh5QS8FLh+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq9tiiXdibRZ3aQvCWrbsAELRy4QuthV/PtWfJS2qJ0=;
 b=DsWgkepOLOhbHIwPnIms/1vEx0IKKKMxIok95J50SGwtfNne5dGqiKTQIlPn/0c8BEM7FzXpvZ8B1qDIOToifnLQpfjjVzJVcvZVIzDaevZPwP2hCXoNLKN3hawy6oaSKfL8ao0NHp0uietONRnFH/8tmxmYbXxWo/xXpzKnreU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 12:56:32 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%5]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 12:56:32 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: remove EnableGfxOff message for SMU IP
 v13.0.4
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: remove EnableGfxOff message for SMU
 IP v13.0.4
Thread-Index: AQHYqK/+M43TxAvO/E27/BAbfVJb6a2gQ64Q
Date: Fri, 5 Aug 2022 12:56:32 +0000
Message-ID: <CY5PR12MB6369521840402CCA5B9B81C7C19E9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220805094350.2665868-1-tim.huang@amd.com>
 <20220805094350.2665868-2-tim.huang@amd.com>
In-Reply-To: <20220805094350.2665868-2-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-05T12:55:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f28aa51d-7af7-4d23-9ba5-a7c50eb2c9f0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-05T12:56:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: cb3c111e-5695-421a-9190-622e7fe87957
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d734a95-3787-4ac3-1b5a-08da76e1ebba
x-ms-traffictypediagnostic: MN0PR12MB6176:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4w6fxD25CFkAyL9mbkkhAme8ojNXP7dMm7nZlc8wsd7joqPtAcSWpCaZh6Ce/B7p98wTyWG5byoMjpmriAmjAY52JLwEhnwnwMZokteepD/DCs+mQ5lcLwPhrnY8BIhBQgb/2maoq3Nm0v/Q28CxOg1ffqlzoqa0cIqfxIQlIMU8rRoH0mcyNcnVGc6xO1hBv5rqwmb1ss0c4CLbJb2VNgwebTtrSqorfENUjCQbF5qi8RlsrBKBQclHYw6nv4Pn5y5PEiuCgMq9MDAZlymT+yqiBvlpxhGCBMSxqHQfE6JEf/JGBk6tUV0dLH/c/fJVn2RFo1t/G3iygr9y6SLFExY9bbaElrDvB8nSqR8NvFig7p9hdgcnLC4oqJ9+TZgxVE5nEK6TTQfodgUaSxcWEK5+ghWFRwrDfNKn3v6qA6H1KtXIMAx2EWkWZmu70StBE1BJjkpnltsVv/mGPR2kGEkfktAObsYdSRjZ40b7uZZevy0HSLLI3QCxf0CZg+4pwfxCl6LjOAEdF/4W3ry06pTLYq6JwUYnXS3+v851STWSHpq+80v2xmOvCnCE5tA8FzTM17akwOZF/n3ObSf8DmUl7fmHNFYz5Ady5KcWVyuDhxZJ2RihpoUa2gOr+CajNcOrEYFsLCFFO6lh9TaM2YLkHat3mDLyahi0bOX4XjJnEyQV2uCKsb0w5qtqDfXDt/wEI3CHsEkQEG2o3rRTYbN4WbIInuPGkDsQKJE+uW4FOnLQZR8HfIPpXehLH6/Gz/CPBNyY/LOg4FdgPiuUO5n8CG9v5g1uQoK3c4Hc7UOLelftTfxmzmvtoAAuIVxg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(54906003)(5660300002)(26005)(8676002)(66446008)(110136005)(66946007)(66476007)(186003)(66556008)(4326008)(76116006)(316002)(55016003)(33656002)(6506007)(64756008)(86362001)(41300700001)(478600001)(53546011)(52536014)(7696005)(8936002)(38070700005)(2906002)(15650500001)(83380400001)(71200400001)(38100700002)(9686003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/g9aTk0uC0QiQNH2AVc42LfZy4D0SKeOordAn6T/wYK20d7vXPnA4zLYc1Iz?=
 =?us-ascii?Q?knDV2kQkZ2rN3Nl0UpuuXI0gQSsWjEuZwJKv6/Z9vxTRYQn3RsrXVDmEUIAl?=
 =?us-ascii?Q?kMMn4rGv0aFy0Q+LuS8SeUekD/LobVKr4n2MA12PtYciIG/yjzu6YvrvnBnq?=
 =?us-ascii?Q?AanDJ428+KU9V204L/0jbbJskdy1s7LtNe6unrFpLKPmXU8UceKqSFsAOQA9?=
 =?us-ascii?Q?8WoW8GXNi84vGJem4Knuu7zr8j86yrRETg/GZxJ+RFyfD4myu8voFCGSbtNW?=
 =?us-ascii?Q?EWfFa+sVeE4WlzCgLXxI0JqaHNwN9UPat6/1fdORlxOuy9BSMNAhSRegboZV?=
 =?us-ascii?Q?g295+WKi1boIaR2OStBYJWYRldPd6h7Lz3VRvF+iN6tYrLOw8S9oZHsSqZe8?=
 =?us-ascii?Q?eUlpFLxWZXahZXHS7ulRRnSCAAskc83I9wIrIHhrR+5TysQ5Ib+pTX3VX8bc?=
 =?us-ascii?Q?71VRMill/Et+DzHr5h08+gPqCGP0pHU7wb5v+UhX4YddrCNA4NOToaC8/1RS?=
 =?us-ascii?Q?0FMydaUAaTUxClqutA5KWBFk6K1plmYakb4HS4Tx8AMSTpQH+zSKgqYhw4AR?=
 =?us-ascii?Q?jp/AsUgkPaamcY4oUhw0XueashIlXRhqFDxU7vfhh2nPzI8h7M9bFlWG/MCK?=
 =?us-ascii?Q?vSIeZdAM9tEJbZKCY1zqLqW9H8od9jzlhBfkr292y01N7izReYuJvb2PfKn4?=
 =?us-ascii?Q?Z/n89mweTRUidDFD0hUD7AnKi7BIWBUsJpRjM549mMjzbcOZE5QuCHN69o1i?=
 =?us-ascii?Q?Gc5fRREpxG9qciu2JRUBp03rl2Rk0ICJz0S49czqUvHn80qGuTE78aNbQ1zD?=
 =?us-ascii?Q?MuryEc7JD2QDe9iKbhKLXevaBKIrYsjwdDiqmUHbOHXqh/Bd6zsPzANIgTA2?=
 =?us-ascii?Q?da+8o9ZKbxu3oHEawjU4IdwAQFBJBeaV2mZ1qADHwPQ6tcQE6W4oU53kFE8T?=
 =?us-ascii?Q?NDuaEDcy1izPnHZ0m7zSE4CZGT6HM8y0mBKypK5CQL07nWmZkYHOmK/D1MP2?=
 =?us-ascii?Q?QMmqRo9EqNHNwA3JtwAwrKZvvliBdQtBn7w5TmQrqocG/bhf4Y92qMjFhP96?=
 =?us-ascii?Q?2FwwdWyhn3jc2W2jTAIHv00KfNNFxhTOEjRfud8Rs8kyU7p/+p40ZUhYXJd8?=
 =?us-ascii?Q?Fmnc+wqM4lKM6A86TAL3WQ4hO943J2ZL3VJhiBfdPVwFUJAT9kX4d5EeAmjJ?=
 =?us-ascii?Q?PeRXVA1kxZuhSXuX5Q7Zot+Vbr+iwnMUxz/FskRofT3Oq3kbTCjmiiDpFLK4?=
 =?us-ascii?Q?QbrqWMLHOS7lmfB2hZLx/KuXusLH08umRosRJ+/jqIcnqnhhOVb6RhI45I4N?=
 =?us-ascii?Q?Z9T/GnsmGwx7FdJG8Aa7R88nnKQ8U513hCiG/1Gg2JZWDpoaPgYRkMazH47W?=
 =?us-ascii?Q?X6DYhqnXNLw10vNgc3f+55wf/mJVpu4QQC09084EuigHfQxtUAu+Z0b+M8zq?=
 =?us-ascii?Q?ichkj5NCfwZvLweLqR6OdO82MlpJDNzWln62vGrzALjv+rEWyqlKSbT+VXz/?=
 =?us-ascii?Q?j0fiwN1eQE1nNWj4gueVIzP5fKAGEKYtdRsAnbNAXRDL/BB430dJ7p9ZueTU?=
 =?us-ascii?Q?5QKiyBJwLXg7GMI1Nwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d734a95-3787-4ac3-1b5a-08da76e1ebba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 12:56:32.0751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDV4PbUVy1flMzDt8eUBszwJMhMpQ1928O/Di8HwE3Y+H8G5ihEOa+a+LNULzFmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Friday, August 5, 2022 5:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd=
.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: remove EnableGfxOff message for SMU IP =
v13.0.4

The EnableGfxOff message is dropped from the new PMFW ppsmc interface.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 82d3718d8324..64665e8a86e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -71,7 +71,6 @@ static struct cmn2asic_msg_mapping smu_v13_0_4_message_ma=
p[SMU_MSG_MAX_COUNT] =3D
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,		1),
 	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1)=
,
-	MSG_MAP(EnableGfxOff,                   PPSMC_MSG_EnableGfxOff,			1),
 	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
 	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
@@ -226,18 +225,6 @@ static int smu_v13_0_4_system_features_control(struct =
smu_context *smu, bool en)
 	return ret;
 }
=20
-static int smu_v13_0_4_post_smu_init(struct smu_context *smu) -{
-	struct amdgpu_device *adev =3D smu->adev;
-	int ret =3D 0;
-
-	/* allow message will be sent after enable message */
-	ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
-	if (ret)
-		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
-	return ret;
-}
-
 static ssize_t smu_v13_0_4_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -1026,7 +1013,6 @@ static const struct pptable_funcs smu_v13_0_4_ppt_fun=
cs =3D {
 	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location =3D smu_v13_0_set_driver_table_location,
 	.gfx_off_control =3D smu_v13_0_gfx_off_control,
-	.post_init =3D smu_v13_0_4_post_smu_init,
 	.mode2_reset =3D smu_v13_0_4_mode2_reset,
 	.get_dpm_ultimate_freq =3D smu_v13_0_4_get_dpm_ultimate_freq,
 	.od_edit_dpm_table =3D smu_v13_0_od_edit_dpm_table,
--
2.25.1
