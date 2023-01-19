Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF41C38142
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 03:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0401910E88C;
	Thu, 19 Jan 2023 03:36:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C981E10E88C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 03:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdSHb+b8ALiWbxElQl0byKVoanZDU4bSr2OcjtZWpTzF74bAwd34GjGJdgf5GEW4HJvNWZdEPk/+7TyGyT+xnTkUAMG5Cf7o382qYrWJVgM9OhE/GGiuyrQA65uewyH64xh8M3Z5svdH0TwYbN/OVaOaC0xeTg5dSQPUuPc6ODr+DvWdRMN829VHuPGYOOph5GS40fVBXustMfhPMuAM/U4eXciBQklEk8hhG5uclFSowPJh2wsc3tpzlU3AQtQxxcM52lEZ2haddA5tNPLUCHWcGQ2vsJR1fSebqkLyNkXr/Lmv4CCGmTmySsporKOE9Dnu8QiMFvyNtzt5NeS5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o4aKIwoNHHvIbIXfrb2npjlU7L0d4EBSDOQZu/5fPk=;
 b=UFlD2FmgugzTEzH+EHsLHr3VHLrNF/bEHMSTRNIbA94qKS2DilPnHzgjTl5tjxJMrVBFykm0QwASAMvbzaP8G5GMPX2Nvufj4VAfdeof88tiVs4X3gmd9RlNRCJheBAz72LQig9eNKY9hb8UAAIt1ZK068B3xwTViXBUbTjghcFt8LMzBZY6l+T0i+rBMezd5UaPKf1v+5siFZxz+r8HP41uK52Cxh1tatrvdCpIlFaLjTsZEu7Ips94q5sRPsEe4ekWH3CjemrUl41mKHnL2Tijj2fauGo2w+Ooc/w8i2rLR9VDlaF4ycMJYE2mlfbtGW11m/V8tovgyeqWU5lJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o4aKIwoNHHvIbIXfrb2npjlU7L0d4EBSDOQZu/5fPk=;
 b=M4NphKts6N1AiJ9GZA9n02Zg+INWF5iaELXFP4Yfx9grpK0EIFdD4FzBix+4Y80o6dh/qodYLb5uRkVNzA9wfgbUWXvgCz6cVDxkP4yzx99XCw3pnqOPHZX3GonoGtl4Vb+Ju5jQ4q+V29FhJGBWxX5CB0D738cmg3hbkclnui0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 03:36:01 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 03:36:01 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
Thread-Topic: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
Thread-Index: AQHZK0jqONXIjStkjkSCHNdoJy6p2a6lFxWw
Date: Thu, 19 Jan 2023 03:36:01 +0000
Message-ID: <CY5PR12MB6369F5E002C1EAD6E0E33391C1C49@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230118142611.1780725-1-alexander.deucher@amd.com>
 <20230118142611.1780725-2-alexander.deucher@amd.com>
In-Reply-To: <20230118142611.1780725-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-19T03:33:51Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1f516132-aec4-4d9c-85a2-2fe82890c3f4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-19T03:35:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6a14f17e-83cd-40ac-86e1-9ad48895edb8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW3PR12MB4570:EE_
x-ms-office365-filtering-correlation-id: 7d44c1d2-0a58-4a27-e27a-08daf9ce4953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUj0b/YTlzvcFnJj+J08dyFmBkrO6fvcp6QEcYzR/QSLMFbme/oN09UMH5nf1/Wr9FQcsLyc5+rxi4Qv3ByryceaRyRRfFc+PGZ98DboGqL+naJajly+GrQEw5CzCV7Mp8K0hyKXWVgG4vRXI0EpLV+k6t5WYpBml5t0gTnJn1uWJ2HJGFsVdEZceB0Od84rsptL37+vLeg7jgOF9VTw7+lfKO5U5YLzIwfQLn6wWu80Z6xVrcGxoept4fvibmz/7xXVx/vDSH1CZPiLEPs3ntBiIpdoT7njS34h3ZKIUOcqPC0CRLvQHzrCbWCpzfo+WNNFgB56CUr5HLHLyDnbRav8h6aKuNEJTuAzD4+a/2MSHFZgKNPWgi24HR7MazaS7NSOJ+Rkfyo5WBWCZEwkUYbtXxNWzNBvyiGm+NgvvgBFPC8euPs7WWmIKe34QGG9Y19hvDL3nNw5gSwWWjp7Bq31LINrbvBm27kVs7sdhsC5ejmHNY5cAr46qchsstndswTcD9jt2RRn1qrIVpAb1jMCDaNuyayJ2wujDZCMoLkDLYv9+w+tdiMqiR7mJgBQw1c7dYOcTSi7p2IlXvr37omjFTp+kHuwHB5y5+n//eWDt+g0hWPztHWI5IA4X2L/K8TAHddzSOtUnXRtiglqwypvOcprA15L8Lb87OVVmlEy1P83GPExO2fT4SB1kgkkIPzROy8GMbMGRZ7sYrq/sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(38100700002)(122000001)(66946007)(38070700005)(33656002)(76116006)(66476007)(5660300002)(8936002)(52536014)(2906002)(55016003)(66556008)(64756008)(8676002)(4326008)(41300700001)(26005)(9686003)(66446008)(186003)(83380400001)(7696005)(53546011)(110136005)(71200400001)(86362001)(478600001)(316002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aP4e6jc8VwLIy7o5mbYoZ/oYXsJG9vZ+q2k4u7V1gJZbDMRFsxZD07l8mzTZ?=
 =?us-ascii?Q?KqAM6YWe/zU9GQ63b8j84XZGDWFeETJFr30triFIR8CJsMyD1yvqvfO2xXpT?=
 =?us-ascii?Q?lqg+c8HbEeIclkveI541iad+k0UVRrxVwSTHkorBuY/oh07eA9zKiC2Quz9G?=
 =?us-ascii?Q?bsQT+eOhu8e/bRm8CKUb1YI1sGJnxTqHAJTpypD7P2twDXh4pahZVFqLe7uj?=
 =?us-ascii?Q?AWmHPnqczhJNhbfTkrmgw4rxKBGmXBSiqlAnMo8NRh8H/rlIuIGKoEPjn6VH?=
 =?us-ascii?Q?qygQqMXcY5c18sXbk+cbdSIw4uZlZCvEX1gFymKXoKKw908Y1NnoRL4FbhvP?=
 =?us-ascii?Q?CHkTVrObUTT9lfISqAMAj7BmRPqdevwwQhVR+ahRUIKb9c7oeYKvKuW4oY3r?=
 =?us-ascii?Q?Bq3RYz2VxgZUnkLWsqISRP+M7VuJ4oHfPv6GpPeKI6NH8KfnZvZer3g1rLZz?=
 =?us-ascii?Q?oRBfDFW4YLTBRldbOmPnrkI13/OFo5aUfaUkBDoWX7sJscOtIH9GlQK6+4da?=
 =?us-ascii?Q?UunD4bXR7pqn9n2qXmL77zbID28fzk0eFckkxqJIsOcPYczk47aQdY0XzCgc?=
 =?us-ascii?Q?u0y/EoeuBHay7nSLuwy3tTDSr9W9cgpgQOeVoPbC5Y4oCtyorUHv3j0qhjm7?=
 =?us-ascii?Q?vOTjIhXXicikUR2tZzs9MgJPKjaeUYRMQcrBnLS+XX+n7lk8DXOhwj9v96uo?=
 =?us-ascii?Q?DY428A8c9ygMC3G7vDdp/XrtWSd5qGPpKj1Be04h0hqtGLzjJh5ODOheHxa9?=
 =?us-ascii?Q?izpdcd3yOiek7TiLxQKflVA2hTqIZsPVyUUlFXa0/u4MO23FwmpBR0YnrfZy?=
 =?us-ascii?Q?MwMb6FdeQ5NQd/6u3VCuBJ9fRjCot0aCW4MnmfFmHq6RA/9MHR1XyFueRGsh?=
 =?us-ascii?Q?fkzqAufK04yByV3zEm8SRoQbTlyv/qFPISL+hLJ92HULO077She9AEyBjD/b?=
 =?us-ascii?Q?7vtTfJTCon7Q8hD/bAXuMcjq1HM6RcIR1VGahxOkjf8CJhQkNx9sGt4bn3I/?=
 =?us-ascii?Q?0uzHFFYupBxFgeaSZaABbR23lk+Tx9SaIceh8Lf2Vtorzy1WnT9zTbxz2A6i?=
 =?us-ascii?Q?3VebhyiVsRKhS+Sy1Aa3vdNj1i57YWh5ynb6bYwfbYmTr5oh3oqtQUHE7+2O?=
 =?us-ascii?Q?kBkpCyAsaZuJ69wE29CWsBl3cshDm6wZHP3+y/+vUf3MaD11MqvvH8bs13Hw?=
 =?us-ascii?Q?hW13rY665B1Bk8KFt0eKFKhF4UrpiFXn0GofLyh1oQhdYnTKeftmtXibYFAF?=
 =?us-ascii?Q?MaReOMbgb99CwrmVg6ViCs1KcpC8lZ6q/bD7CkMsSzi/J59EE8YpxS2/Riy5?=
 =?us-ascii?Q?geYHhoR5/tfJvJmZo650zZQs1DdrU4L6DEWVNOKMwwud0vZXa7TUc57z+PpO?=
 =?us-ascii?Q?8CfQrHqxpwpnXEDgHB7CUIfNFSg6sXhfiErLOeOj33nDlP0w4icdYGCLbFJx?=
 =?us-ascii?Q?rQm1XJaopbUduX0Gvb5sEhfnF0V3ZeZ2jRct6OolLagemt2GnP0TmEeWI6ys?=
 =?us-ascii?Q?W/p8OmGqouVbLtTeyfjlzQv8uwYk6ZwVwdlQ6V1e50LDj18iKLJ59xrsAC9s?=
 =?us-ascii?Q?FiWAclapNoicdBpBEws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d44c1d2-0a58-4a27-e27a-08daf9ce4953
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 03:36:01.4535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Gn8LpZjCHgXku3wJd+sj3A9/E8HZcVKiX+LdlIDs1lYUR3PCuA2cB2ohfGTKa/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570
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
Cc: "Li, Roman" <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>=20
Sent: Wednesday, January 18, 2023 10:26 PM=20
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4

Causes flickering or white screens in some configurations.
Disable it for now until we can fix the issue.

Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7167a7b63f8c..b8ae51345668 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1502,7 +1502,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
-		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support =3D true;
 			break;
--=20
2.39.0
